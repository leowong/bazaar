class AddStoreIdToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :composer_id, :integer
  end

  def self.down
    remove_column :comments, :composer_id
  end
end
