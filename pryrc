if RUBY_VERSION < "1.9"
  require "rubygems"
end

begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| output.puts value.ai }

rescue LoadError => err
  puts "no awesome_print :("
end

# use Rails commands
# Load plugins that I have whitelisted (only the doc plugin -> pry-doc)
Pry.config.should_load_plugins = false
Pry.plugins["doc"].activate!

rails = File.join(Dir.getwd, 'config', 'environment.rb')

if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails

  if Rails.version[0..0] == "2"
    require 'console_app'
    require 'console_with_helpers'
  elsif Rails.version[0..0] == "3"
    require 'rails/console/app'
    require 'rails/console/helpers'
  else
    warn "[WARN] cannot load Rails console commands (Not on Rails 2 or Rails 3?)"
  end
end

def bm(repetitions=100,&block)
  return unless block_given?
  require 'benchmark'

  Benchmark.bmbm do |b|
    b.report { repetitions.times(&block) }
  end
end

Pry.prompt = [proc { |obj, nest_level, _| "(#{obj}):#{nest_level} > " }, proc { |obj, nest_level, _| "(#{obj}):#{nest_level} * " }]


