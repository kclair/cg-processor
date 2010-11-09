class AddStatusToRemoteAsset < ActiveRecord::Migration
  def self.up
    add_column :remote_assets, :status, :string
    add_column :remote_assets, :status_msg, :string
  end

  def self.down
    remove_column :remote_assets, :status_msg
    remove_column :remote_assets, :status
  end
end
