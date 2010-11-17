class AssetWorker < Workling::Base

  def process(options)
    asset = RemoteAsset.find(options[:id])
    asset.process
  end

end
