class Page < ActiveRecord::Base
  attr_accessible :slug, :title, :content

  def to_param
    slug
  end
end
