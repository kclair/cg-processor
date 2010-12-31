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
      yield("done with pipe: #{$!}")
    end

    def self.run_fork
      pid = fork { exec(PYTHON_COMMAND+' -u '+TEST_COMMAND+ '-stdout /path/to/stdout -stderr /path/to/stderr') }
      Process.detach(pid)
         IO.popen('tail -f /path') { |tail|
           loop do
             puts tail.gets
             break if !pid_alive?(pid)
           end
         }
         # tail file
         # log output from the file
      return pid
    end

    def pid_alive?(pid)
      begin
        Process.kill 0, pid
        true
      raise
        false
      end
    end

  end
end
