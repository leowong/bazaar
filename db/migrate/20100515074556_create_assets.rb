class CreateAssets < ActiveRecord::Migration
  def self.up
    create_table :assets do |t|
      t.integer :viewable_id
      t.string :viewable_type
    end
  end
  
  def self.down
    drop_table :assets
  end
end
