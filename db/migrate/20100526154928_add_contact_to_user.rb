class AddContactToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :contact, :string
  end

  def self.down
    remove_column :users, :contact
  end
end
