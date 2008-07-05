module RubyWarrior
  class UI
    def self.out_stream=(stream)
      @out = stream
    end
    
    def self.out
      @out ||= StringIO.new
    end
    
    def self.puts(msg)
      out.puts(msg)
    end
  end
end
