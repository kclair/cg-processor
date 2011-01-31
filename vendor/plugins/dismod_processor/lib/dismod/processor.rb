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

    def self.run_fork(id)
      workdir = WORKING_DIR+'/asset_'+id.to_s
      command = RUBY_COMMAND+' '+TEST_FORK_COMMAND+ ' -o '+workdir+'/stdout/ -e '+workdir+'/stderr'
      if Process.respond_to?(:fork)
        trap("CLD") { 
          yield self.tail_files(workdir)
          return
        }
        exec(command) if fork == nil
        loop do
          yield self.tail_files(workdir)
          sleep 2 
        end
      else
        puts "No fork available"
      end
    end

    private

    def self.tail_files(dir)
      ret = ''
      ['stderr', 'stdout'].each do |file|
        [Dir.glob(dir+'/'+file+'/*')].each do |d|
          d.each do |f|
            ret = (tail = IO.readlines(f)[-1]) ? (ret+tail) : ret
          end
        end
      end
      return ret
    end

  end
end
