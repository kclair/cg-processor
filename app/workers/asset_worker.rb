class AssetWorker < Workling::Base

  def process(options)
    @asset = RemoteAsset.find(options[:id])
    #@asset.update_attribute(:status, 'queued')
    #@asset.save!
    @asset.process
  end

end
