class AssetWorker < Workling::Base

  def process(options)
    asset = RemoteAsset.find(options[:id])
    asset.process
    Workling.return.set(options[:uid], asset.status)
  end

end
