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

    def self.run_fork(id, workdir)
      command = RUBY_COMMAND+' '+TEST_FORK_COMMAND+ ' -o '+workdir+'/stdout/ -e '+workdir+'/stderr'
      if Process.respond_to?(:fork)
        #trap("CLD") { 
        #  return
        #}
        exec(command) if fork == nil
        Process.wait
        return $?.exitstatus
      else
        puts "No fork available"
      end
    end

  end
end
