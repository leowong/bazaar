class AddAddressToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :address, :string
    add_column :users, :latitude, :string, :precision => 8, :scale => 6, :default => 0.0
    add_column :users, :longitude, :string, :precision => 9, :scale => 6, :default => 0.0
  end

  def self.down
    remove_column :users, :longitude
    remove_column :users, :latitude
    remove_column :users, :address
  end
end
