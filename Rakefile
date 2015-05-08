require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << %w(test lib)
  t.pattern = 'test/**/*_test.rb'
end


desc "Run tests"
task :default => :test
