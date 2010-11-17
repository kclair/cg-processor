class RemoteAssetObserver < ActiveRecord::Observer
  
  def after_create(asset)
    if @uuid = AssetWorker.asynch_process(:id => asset.id)
      asset.update_attributes(:status => 'queued', :worker_uuid => @uuid)
      asset.save!
    end
  end

end
