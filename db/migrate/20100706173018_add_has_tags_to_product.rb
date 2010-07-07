class AddHasTagsToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :has_tags, :boolean

    Product.reset_column_information
    Product.find(:all).each do |p|
      p.update_attribute(:has_tags, true) unless p.tags.empty?
    end
  end

  def self.down
    remove_column :products, :has_tags
  end
end
