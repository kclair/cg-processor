module Dismod 
  module Processor

    # accepts a block that does something with the output
    def self.run_pipe
      IO.popen(PYTHON_COMMAND+' -u '+TEST_COMMAND+' 2>&1', 'r+') { |o|
        if block_given?
          while str = o.gets
            yield(str)
          end
        end
      }
    end

    def self.run_fork
      pid = fork { exec(PYTHON_COMMAND+' -u '+TEST_COMMAND) }
      Process.detach(pid)
      return pid
    end

  end
end
