module Dismod 
  module Processor
    require 'open3'
    include Open3

    def self.run
       # this prints the output in order but only after the command is finished
#       Open3.popen3(PYTHON_COMMAND+ ' '+TEST_COMMAND) { |stdin, stdout, stderr|
#         while str = (stdout.gets or stderr.gets)
#           puts 'popen: '+str
#         end
#       }

       # this has strange behavior.......
       # it prints the stderr lines as they are printed from the python script
       # and then it prints all the stdout lines at once when the command is finished 
       # based on my reading thus far, it seems like this might be an OS buffering issue
      IO.popen(PYTHON_COMMAND+' '+TEST_COMMAND+' 2>&1', 'r+') { |o|
        while str = o.gets
          puts 'from popen: '+str
        end
      }

    end

  end
end
