class ChangeLatlngTypeToDecimal < ActiveRecord::Migration
  def self.up
    remove_column :users, :longitude
    remove_column :users, :latitude
    add_column :users, :latitude, :decimal, :precision => 8, :scale => 6, :default => 0.0
    add_column :users, :longitude, :decimal, :precision => 9, :scale => 6, :default => 0.0
  end

  def self.down
    remove_column :users, :longitude
    remove_column :users, :latitude
    add_column :users, :latitude, :string
    add_column :users, :longitude, :string
  end
end
