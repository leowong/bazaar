class Asset < ActiveRecord::Base
  attr_accessible :viewable_id, :viewable_type, :attachment
  belongs_to :viewable, :polymorphic => true, :counter_cache => true, :touch => true
  acts_as_list :scope => :viewable
end
