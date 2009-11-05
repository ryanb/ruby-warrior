class MockIO
  class Timeout < Exception
  end
  
  def initialize(receiver = nil)
    @buffer = ""
    @receiver = receiver || MockIO.new(self)
  end
  
  def gets
    1000.times do |n|
      sleep 0.01 if n > 800 # throttle if it seems to be taking a while
      unless @buffer.empty?
        content = @buffer
        @buffer = ""
        return content
      end
    end
    raise Timeout, "MockIO Timeout: No content was received for gets."
  end
  
  def gets_until_include(phrase)
    content = gets
    while !content.include?(phrase)
      begin
        content += gets
      rescue Timeout
        raise "Unable to find \"#{phrase}\" in \"#{content}\""
      end
    end
    content
  end
  
  # TODO make this thread safe
  def puts(str)
    @receiver << "#{str}\n"
  end
  
  def print(str)
    @receiver << str.to_s
  end
  
  def <<(str)
    @buffer << str
  end
  
  def start
    main_thread = Thread.current
    Thread.new do
      begin
        yield(@receiver)
      rescue Exception => e
        main_thread.raise(e)
      end
    end
  end
end
