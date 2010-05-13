class AddUserIdToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :user_id, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :products, :user_id
  end
end
