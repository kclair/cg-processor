class RemoteAsset < ActiveRecord::Base

  require 'base64'

  def source=(base64_source)
    file = File.join(RAILS_ROOT, 'tmp', "asset_#{Time.now.to_i}")
    File.open(file, "wb") { |f| f.write(Base64.decode64(base64_source)) }
  end

end
