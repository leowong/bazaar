class AddAssetsCountToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :assets_count, :integer, :default => 0

    Product.reset_column_information
    Product.find(:all).each do |p|
      Product.update_counters p.id, :assets_count => p.images.length
    end
  end

  def self.down
    remove_column :products, :assets_count
  end
end
