require 'dismod/processor.rb'

module Dismod::Processor
  PYTHON_COMMAND   = `which python`.chomp
  TEST_COMMAND = File.dirname(__FILE__) + '/bin/test.py'
end
