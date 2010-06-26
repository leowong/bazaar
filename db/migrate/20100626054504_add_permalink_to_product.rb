class AddPermalinkToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :permalink, :string
    add_index :products, :permalink

    Product.reset_column_information
    Product.find(:all).each do |p|
      p.update_permalink
    end
  end

  def self.down
    remove_index :products, :permalink
    remove_column :products, :permalink
  end
end
