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

rescue LoadError
  nil
end

def bm(repetitions=100,&block)
  return unless block_given?
  require 'benchmark'

  Benchmark.bmbm do |b|
    b.report { repetitions.times(&block) }
  end
end

IRB.conf[:PROMPT][:CUSTOM] = {
  :RETURN      => "=> %s\n",
  :PROMPT_I    => "%03n:%i> ",
  :PROMPT_N    => "%03n:%i> ",
  :PROMPT_S    => "%03n:%i%l ",
  :PROMPT_C    => "%03n:%i* "
}

IRB.conf[:PROMPT_MODE] = :CUSTOM