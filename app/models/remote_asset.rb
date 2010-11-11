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
=end

  def process 
    fetch_source
    self.status ||= 'success'
    self.save!
  end

  def fetch_source
    if source_url.nil?
      self.status = 'failure'
      return
    end
    begin
      source = open(source_url)  # open(source_url).read
      File.open("#{RAILS_ROOT}/tmp/#{filename}", 'w') { |f|
        f.write(source.read)
      }
    rescue SystemCallError
      self.status = "failure"
    end
  end

end
