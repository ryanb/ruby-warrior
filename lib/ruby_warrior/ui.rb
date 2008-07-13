module RubyWarrior
  class UI
    def self.in_stream=(in_stream)
      @in = in_stream
    end
    
    def self.out_stream=(stream)
      @out = stream
    end
    
    def self.puts(msg)
      @out.puts(msg) if @out
    end
    
    def self.print(msg)
      @out.print(msg) if @out
    end
    
    def self.gets
      @in ? @in.gets : ''
    end
    
    def self.request(msg)
      print(msg)
      gets.chomp
    end
    
    def self.ask(msg)
      request("#{msg} [yn] ") == 'y'
    end
    
    # REFACTORME
    def self.choose(item, options)
      if options.length == 1
        response = options.first
      else
        options.each_with_index do |option, i|
          if option.kind_of? Array
            puts "[#{i+1}] #{option.last}"
          else
            puts "[#{i+1}] #{option}"
          end
        end
        choice = request("Choose #{item} by typing the number: ")
        response = options[choice.to_i-1]
      end
      if response.kind_of? Array
        response.first
      else
        response
      end
    end
  end
end
