class Asset < ActiveRecord::Base
  attr_accessible :viewable_id, :viewable_type, :attachment
  belongs_to :viewable, :polymorphic => true
end
