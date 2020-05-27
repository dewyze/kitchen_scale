require "rspec/core/rake_task"
require "rubocop/rake_task"

RuboCop::RakeTask.new

Rake::Task["spec"].clear
RSpec::Core::RakeTask.new(:spec)

desc "Rubocop changed"
task :rubocop_changed do
  puts "Running rubocop on changed files..."
  system('bin/rubocop -a $(git diff HEAD --name-only --diff-filter=MA | grep "\.rb$" & git ls-files --other --exclude-standard --exclude bin | grep "\.rb$" | sort | uniq)')
end

task default: %w[spec rubocop_changed]
