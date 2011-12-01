if RUBY_VERSION < "1.9"
  require "rubygems"
end

begin
  require "awesome_print"


  unless IRB.version.include?('DietRB')
    IRB::Irb.class_eval do
      def output_value
        ap @context.last_value
      end
    end
  else # MacRuby
    IRB.formatter = Class.new(IRB::Formatter) do
      def inspect_object(object)
        object.ai
      end
    end.new
  end

  module AwesomePrint
    module TimeClasses

      def self.included(base)
        base.send :alias_method, :cast_without_time_classes, :cast
        base.send :alias_method, :cast, :cast_with_time_classes
      end

      def cast_with_time_classes(object,type)
        cast = cast_without_time_classes(object,type)
        if object.is_a?(::Date) or object.is_a?(::DateTime)
          cast = :date
        end
        cast
      end

      def awesome_date(object)
        colorize(object.inspect, :time)
      end

    end
  end

  AwesomePrint::Formatter.send(:include,AwesomePrint::TimeClasses)

rescue LoadError
  nil
end

IRB.conf[:PROMPT][:CUSTOM] = {
  :RETURN      => "=> %s\n",
  :PROMPT_I    => "%03n:%i> ",
  :PROMPT_N    => "%03n:%i> ",
  :PROMPT_S    => "%03n:%i%l ",
  :PROMPT_C    => "%03n:%i* "
}

IRB.conf[:PROMPT_MODE] = :CUSTOM