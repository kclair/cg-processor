class AddResultsFieldsToRemoteAssets < ActiveRecord::Migration
  def self.up
    add_column :remote_assets, :mime_from, :string
    add_column :remote_assets, :mime_to, :string
    add_column :remote_assets, :respond_to_create, :string
    add_column :remote_assets, :respond_to_update, :string
  end

  def self.down
    remove_column :remote_assets, :respond_to_update
    remove_column :remote_assets, :respond_to_create
    remove_column :remote_assets, :mime_to
    remove_column :remote_assets, :mime_from
  end
end
