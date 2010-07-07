class RemoveHasTagsFromProduct < ActiveRecord::Migration
  def self.up
    remove_column :products, :has_tags
  end

  def self.down
    add_column :products, :has_tags, :boolean

    Product.reset_column_information
    Product.find(:all).each do |p|
      p.update_attribute(:has_tags, true) unless p.tags.empty?
    end
  end
end
