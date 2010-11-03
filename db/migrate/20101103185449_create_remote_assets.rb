class CreateRemoteAssets < ActiveRecord::Migration
  def self.up
    create_table :remote_assets do |t|
      t.string :mime_type
      t.string :filename

      t.timestamps
    end
  end

  def self.down
    drop_table :remote_assets
  end
end
