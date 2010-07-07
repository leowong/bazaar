class AddPublishedToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :published, :boolean, :default => false

    Product.reset_column_information
    Product.find(:all).each do |p|
      p.update_attribute(:published, true) unless p.category.nil?
    end
  end

  def self.down
    remove_column :products, :published
  end
end
