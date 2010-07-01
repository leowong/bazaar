class Page < ActiveRecord::Base
  attr_accessible :slug, :title, :content
end
