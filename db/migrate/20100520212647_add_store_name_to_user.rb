class AddStoreNameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :store_name, :string
  end

  def self.down
    remove_column :users, :store_name
  end
end
