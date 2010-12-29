module Dismod 
  module Processor

    # accepts a block that does something with the output
    def self.run
      IO.popen(PYTHON_COMMAND+' -u '+TEST_COMMAND+' 2>&1', 'r+') { |o|
        if block_given?
          while str = o.gets
            yield(str)
          end
        end
      }

    end

  end
end
