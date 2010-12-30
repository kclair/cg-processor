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
    check_filename
    fetch_source
    process_file
  end

  # this should be moved into a module or a plugin that 
  # can be subclassed for different mime types
  def process_file
    if self.mime_from == 'test'
      pid = Dismod::Processor.run_fork
    end
  end

  def check_filename
    log_status('processing', 'checking filename')
    return if self.filename
    write_attribute(:filename, 'asset_'+Time.now.to_s)
  end

  def fetch_source
    log_status(nil, 'fetching source')
    if source_url.nil?
      log_status('failed', 'source url blank')
      return
    end
    begin
     source = open(source_url)  # open(source_url).read
     File.open("#{RAILS_ROOT}/tmp/#{self.filename}", 'w') { |f|
       f.write(source.read)
     }
    rescue SystemCallError
      log_status('failed', $!)
    end
  end

  def log_status(status=nil, status_msg=nil)
    write_attribute(:status, status) if status
    return if !status_msg
    status_msg = (read_attribute(:status_msg) ? read_attribute(:status_msg) : '')+status_msg
    write_attribute(:status_msg, status_msg)
    save!
  end
end
