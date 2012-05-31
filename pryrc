if RUBY_VERSION < "1.9"
  require "rubygems"
end

def bm(repetitions=100,&block)
  return unless block_given?
  require 'benchmark'

  Benchmark.bmbm do |b|
    b.report { repetitions.times(&block) }
  end
end

Pry.prompt = [proc { |obj, nest_level, _| "(#{obj}):#{nest_level} > " }, proc { |obj, nest_level, _| "(#{obj}):#{nest_level} * " }]
