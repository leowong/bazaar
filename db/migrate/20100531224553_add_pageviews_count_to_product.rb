class AddPageviewsCountToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :pageviews_count, :integer, :default => 0
  end

  def self.down
    remove_column :products, :pageviews_count
  end
end
