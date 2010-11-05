class RemoveMimeTypeFromRemoteAssets < ActiveRecord::Migration
  def self.up
    remove_column :remote_assets, :mime_type
  end

  def self.down
    add_column :remote_assets, :mime_type, :string
  end
end
