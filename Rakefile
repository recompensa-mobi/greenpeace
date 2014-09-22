require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'bundler/gem_tasks'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color', '--format', 'documentation']
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = [
    'lib/**/*.rb',
    'spec/**/*.rb',
    'Rakefile',
    'Vagrantfile'
  ]
end

task all: [:spec, :rubocop]

task default: :all
