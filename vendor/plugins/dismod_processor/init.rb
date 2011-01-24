require 'dismod/processor.rb'

module Dismod::Processor
  PYTHON_COMMAND   = `which python`.chomp
  RUBY_COMMAND = `which ruby`.chomp
  TEST_COMMAND = File.dirname(__FILE__) + '/bin/test.py'
  TEST_FORK_COMMAND = File.dirname(__FILE__) + '/bin/test_fork.rb'
  WORKING_DIR = "/tmp"
end
