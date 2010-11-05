class AddGetSourceUriToRemoteAssets < ActiveRecord::Migration
  def self.up
    add_column :remote_assets, :source_url, :string
  end

  def self.down
    remove_column :remote_assets, :source_url
  end
end
