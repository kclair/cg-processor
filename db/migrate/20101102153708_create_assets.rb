class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.string :mime_type
      t.string :filename

      t.timestamps
    end
  end

  def self.down
    drop_table :assets
  end
end
