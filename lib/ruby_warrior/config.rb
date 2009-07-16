module RubyWarrior
  class Config
    class << self
      attr_writer :path_prefix
      
      def path_prefix
        @path_prefix || "."
      end
    end
  end
end