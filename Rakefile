require 'bundler/gem_tasks'
require 'rspec'
require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  # t.pattern = './spec/**/*_spec.rb' # it's default.
  # Put spec opts in a file named .rspec in root
end