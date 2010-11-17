class AddWorkerUuidToRemoteAssets < ActiveRecord::Migration
  def self.up
    add_column :remote_assets, :worker_uuid, :string
  end

  def self.down
    remove_column :remote_assets, :worker_uuid
  end
end
