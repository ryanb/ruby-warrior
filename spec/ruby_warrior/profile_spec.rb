require 'spec_helper'

describe RubyWarrior::Profile do
  before(:each) do
    @profile = RubyWarrior::Profile.new
  end
  
  it "should have warrior name" do
    @profile.warrior_name = 'Joe'
    @profile.warrior_name.should == 'Joe'
  end
  
  it "should start level number at 0" do
    @profile.level_number.should be_zero
  end
  
  it "should start score at 0 and allow it to increment" do
    @profile.score.should be_zero
    @profile.score += 5
    @profile.score.should == 5
  end
  
  it "should have no abilities and allow adding" do
    @profile.abilities.should == []
    @profile.abilities += [:foo, :bar]
    @profile.abilities.should == [:foo, :bar]
  end
  
  it "should encode with marshal + base64" do
    @profile.encode.should == Base64.encode64(Marshal.dump(@profile))
  end
  
  it "should decode with marshal + base64" do
    RubyWarrior::Profile.decode(@profile.encode).warrior_name.should == @profile.warrior_name
  end
  
  it "load should read file, decode and set player path" do
    profile = 'profile'
    profile.expects(:player_path=).with('path/to')
    File.expects(:read).with('path/to/.profile').returns('encoded_profile')
    RubyWarrior::Profile.expects(:decode).with('encoded_profile').returns(profile)
    RubyWarrior::Profile.load('path/to/.profile').should == profile
  end

  
  it "should add abilities and remove duplicates" do
    @profile.add_abilities(:foo, :bar, :blah, :bar)
    @profile.abilities.should == [:foo, :bar, :blah]
  end
    
  it "should fetch new level with current number" do
    @profile.level_number = 1
    @profile.current_level.number.should == 1
  end

  it "should fetch next level" do
    @profile.level_number = 1
    @profile.next_level.number.should == 2
  end

  it "should enable epic mode and reset scores if nil" do
    @profile.epic_score = nil
    @profile.current_epic_score = nil
    @profile.enable_epic_mode
    @profile.should be_epic
    @profile.epic_score.should be_zero
    @profile.current_epic_score.should be_zero
  end
  
  it "should override epic score with current one if it is higher" do
    @profile.enable_epic_mode
    @profile.epic_score.should be_zero
    @profile.average_grade.should be_nil
    @profile.current_epic_score = 123
    @profile.current_epic_grades = { 1 => 0.7, 2 => 0.9 }
    @profile.update_epic_score
    @profile.epic_score.should == 123
    @profile.average_grade.should == 0.8
  end
  
  it "should not override epic score with current one if it is lower" do
    @profile.enable_epic_mode
    @profile.epic_score = 124
    @profile.average_grade = 0.9
    @profile.current_epic_score = 123
    @profile.current_epic_grades = { 1 => 0.7, 2 => 0.9 }
    @profile.update_epic_score
    @profile.epic_score.should == 124
    @profile.average_grade.should == 0.9
  end
  
  it "should not calculate average grade if no grades are present" do
    @profile.enable_epic_mode
    @profile.current_epic_grades = {}
    @profile.calculate_average_grade.should be_nil
  end

  it "should remember current level number as last_level_number" do
    @profile.level_number = 7
    @profile.enable_epic_mode
    @profile.last_level_number.should == 7
  end

  it "should enable normal mode by clearing epic scores and resetting last level number" do
    @profile.last_level_number = 7
    @profile.epic_score = 123
    @profile.current_epic_score = 100
    @profile.current_epic_grades = { 1 => 100 }
    @profile.average_grade = "C"
    @profile.enable_normal_mode
    @profile.should_not be_epic
    @profile.epic_score.should be_zero
    @profile.current_epic_score.should be_zero
    @profile.last_level_number.should be_nil
    @profile.average_grade.should be_nil
    @profile.current_epic_grades.should == {}
    @profile.level_number.should == 7
  end

  it "should be no level after epic if last level isn't specified" do
    @profile.last_level_number = nil
    @profile.should_not be_level_after_epic
  end
  
  describe "with tower path" do
    before(:each) do
      @profile.warrior_name = "John Smith"
      @profile.tower_path = 'path/to/tower'
    end
    
    it "save should write file with encoded profile" do
      file = stub
      file.expects(:write).with('encoded_profile')
      File.expects(:open).with(@profile.player_path + '/.profile', 'w').yields(file)
      @profile.expects(:encode).returns('encoded_profile')
      @profile.save
    end
    
    it "should have a nice string representation" do
      @profile.warrior_name = 'Joe'
      @profile.to_s.should == "Joe - tower - level 0 - score 0"
    end
    
    it "should include epic score in string representation" do
      @profile.warrior_name = 'Joe'
      @profile.enable_epic_mode
      @profile.to_s.should == "Joe - tower - first score 0 - epic score 0"
    end
    
    it "should include epic score with grade in string representation" do
      @profile.warrior_name = 'Joe'
      @profile.enable_epic_mode
      @profile.average_grade = 0.7
      @profile.to_s.should == "Joe - tower - first score 0 - epic score 0 (C)"
    end
    
    it "should guess at the player path" do
      @profile.player_path.should == './rubywarrior/john-smith-tower'
    end
  
    it "should use specified player path" do
      @profile.player_path = "path/to/player"
      @profile.player_path.should == "path/to/player"
    end
  
    it "should load tower from path" do
      RubyWarrior::Tower.expects(:new).with('path/to/tower').returns('tower')
      @profile.tower.should == 'tower'
    end
  end
end
