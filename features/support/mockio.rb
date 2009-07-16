class MockIO
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
    raise "MockIO Timeout: No content was received for gets."
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
    Thread.abort_on_exception = true
    @thread = Thread.new do
      yield(@receiver)
    end
  end
end
