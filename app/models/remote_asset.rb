class RemoteAsset < ActiveRecord::Base

=begin
    t.string   "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mime_from"
    t.string   "mime_to"
    t.string   "respond_to_create"
    t.string   "respond_to_update"
    t.string   "source_url"
    t.string 	"status"  # pending, ???, success, failure
    t.string	"status_msg"
    t.string   "worker_uuid"
=end

  named_scope :in_progress, :conditions => ['status = "queued" OR status = "processing"']

  def process 
    log_status("processing", 'beginning do_process')
    check_filename and 
    fetch_source and
    process_file
  end

  # this should be moved into a module or a plugin that 
  # can be subclassed for different mime types
  def process_file
    Dismod::Processor.run_fork(self.worker_uuid) {|str| self.log_status(nil, str) }
    #Dismod::Processor.run_pipe { |str| self.log_status(nil, str) }
    log_status('succeeded')
  end

  def check_filename
    log_status('processing', 'checking filename')
    return true if self.filename
    write_attribute(:filename, 'asset_'+Time.now.to_s)
    save! 
    return true
  end

  def fetch_source
    log_status(nil, 'fetching source')
    # these should be moved to validators
    if source_url.nil?
      log_status('failed', 'source url blank')
      return false
    end
    begin
      require 'open-uri' if source_url =~ /^http/
      source = open(source_url)
      File.open("#{RAILS_ROOT}/tmp/#{self.filename}", 'w') { |f|
        f.write(source.read)
      }
    rescue SystemCallError
      log_status('failed', $!)
    end
    return true
  end

  def log_status(status=nil, status_msg=nil)
    write_attribute(:status, status) if status
    write_attribute(:status_msg, (read_attribute(:status_msg) || '')+status_msg) if status_msg
    save!
  end
end
