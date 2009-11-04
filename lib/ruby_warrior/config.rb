module RubyWarrior
  class Config
    class << self
      attr_accessor :delay, :in_stream, :out_stream
      attr_writer :path_prefix, :skip_input
      
      def path_prefix
        @path_prefix || "."
      end
      
      def skip_input?
        @skip_input
      end
      
      def reset
        [:@path_prefix, :@skip_input, :@delay, :@in_stream, :@out_stream].each do |i|
          remove_instance_variable(i) if instance_variable_defined?(i)
        end
      end
    end
  end
end
