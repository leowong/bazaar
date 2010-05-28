class AddAbbreviationToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :abbreviation, :string
  end

  def self.down
    remove_column :users, :abbreviation
  end
end
