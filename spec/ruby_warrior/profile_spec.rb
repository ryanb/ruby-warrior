require 'spec_helper'

describe RubyWarrior::Profile do
  before(:each) do
    @profile = RubyWarrior::Profile.new
  end
  
  it "should have warrior name" do
    @profile.warrior_name = 'Joe'
    expect(@profile.warrior_name).to eq('Joe')
  end
  
  it "should start level number at 0" do
    expect(@profile.level_number).to be_zero
  end
  
  it "should start score at 0 and allow it to increment" do
    expect(@profile.score).to be_zero
    @profile.score += 5
    expect(@profile.score).to eq(5)
  end
  
  it "should have no abilities and allow adding" do
    expect(@profile.abilities).to eq([])
    @profile.abilities += [:foo, :bar]
    expect(@profile.abilities).to eq([:foo, :bar])
  end
  
  it "should encode with marshal + base64" do
    expect(@profile.encode).to eq(Base64.encode64(Marshal.dump(@profile)))
  end
  
  it "should decode with marshal + base64" do
    expect(RubyWarrior::Profile.decode(@profile.encode).warrior_name).to eq(@profile.warrior_name)
  end
  
  it "load should read file, decode and set player path" do
    profile = 'profile'
    profile.expects(:player_path=).with('path/to')
    File.expects(:read).with('path/to/.profile').returns('encoded_profile')
    RubyWarrior::Profile.expects(:decode).with('encoded_profile').returns(profile)
    expect(RubyWarrior::Profile.load('path/to/.profile')).to eq(profile)
  end

  
  it "should add abilities and remove duplicates" do
    @profile.add_abilities(:foo, :bar, :blah, :bar)
    expect(@profile.abilities).to eq([:foo, :bar, :blah])
  end
    
  it "should fetch new level with current number" do
    @profile.level_number = 1
    expect(@profile.current_level.number).to eq(1)
  end

  it "should fetch next level" do
    @profile.level_number = 1
    expect(@profile.next_level.number).to eq(2)
  end

  it "should enable epic mode and reset scores if nil" do
    @profile.epic_score = nil
    @profile.current_epic_score = nil
    @profile.enable_epic_mode
    expect(@profile).to be_epic
    expect(@profile.epic_score).to be_zero
    expect(@profile.current_epic_score).to be_zero
  end
  
  it "should override epic score with current one if it is higher" do
    @profile.enable_epic_mode
    expect(@profile.epic_score).to be_zero
    expect(@profile.average_grade).to be_nil
    @profile.current_epic_score = 123
    @profile.current_epic_grades = { 1 => 0.7, 2 => 0.9 }
    @profile.update_epic_score
    expect(@profile.epic_score).to eq(123)
    expect(@profile.average_grade).to eq(0.8)
  end
  
  it "should not override epic score with current one if it is lower" do
    @profile.enable_epic_mode
    @profile.epic_score = 124
    @profile.average_grade = 0.9
    @profile.current_epic_score = 123
    @profile.current_epic_grades = { 1 => 0.7, 2 => 0.9 }
    @profile.update_epic_score
    expect(@profile.epic_score).to eq(124)
    expect(@profile.average_grade).to eq(0.9)
  end
  
  it "should not calculate average grade if no grades are present" do
    @profile.enable_epic_mode
    @profile.current_epic_grades = {}
    expect(@profile.calculate_average_grade).to be_nil
  end

  it "should remember current level number as last_level_number" do
    @profile.level_number = 7
    @profile.enable_epic_mode
    expect(@profile.last_level_number).to eq(7)
  end

  it "should enable normal mode by clearing epic scores and resetting last level number" do
    @profile.last_level_number = 7
    @profile.epic_score = 123
    @profile.current_epic_score = 100
    @profile.current_epic_grades = { 1 => 100 }
    @profile.average_grade = "C"
    @profile.enable_normal_mode
    expect(@profile).not_to be_epic
    expect(@profile.epic_score).to be_zero
    expect(@profile.current_epic_score).to be_zero
    expect(@profile.last_level_number).to be_nil
    expect(@profile.average_grade).to be_nil
    expect(@profile.current_epic_grades).to eq({})
    expect(@profile.level_number).to eq(7)
  end

  it "should be no level after epic if last level isn't specified" do
    @profile.last_level_number = nil
    expect(@profile).not_to be_level_after_epic
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
      expect(@profile.to_s).to eq("Joe - tower - level 0 - score 0")
    end
    
    it "should include epic score in string representation" do
      @profile.warrior_name = 'Joe'
      @profile.enable_epic_mode
      expect(@profile.to_s).to eq("Joe - tower - first score 0 - epic score 0")
    end
    
    it "should include epic score with grade in string representation" do
      @profile.warrior_name = 'Joe'
      @profile.enable_epic_mode
      @profile.average_grade = 0.7
      expect(@profile.to_s).to eq("Joe - tower - first score 0 - epic score 0 (C)")
    end
    
    it "should guess at the player path" do
      expect(@profile.player_path).to eq('./rubywarrior/john-smith-tower')
    end
  
    it "should use specified player path" do
      @profile.player_path = "path/to/player"
      expect(@profile.player_path).to eq("path/to/player")
    end
  
    it "should load tower from path" do
      RubyWarrior::Tower.expects(:new).with('tower').returns('tower')
      expect(@profile.tower).to eq('tower')
    end
  end
end
