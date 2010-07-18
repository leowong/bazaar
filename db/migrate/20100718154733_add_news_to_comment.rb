class AddNewsToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :news, :boolean, :default => false

    Comment.reset_column_information
    Comment.find(:all).each do |c|
      if (c.composer_id && (c.composer_id == c.user_id || (c.user_id == User.find_by_username('admin').id and User.find(c.composer_id).role?(:admin))))
        c.update_attribute(:news, true)
      end
    end
  end

  def self.down
    remove_column :comments, :news
  end
end
