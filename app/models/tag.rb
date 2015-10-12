class Tag < ActiveRecord::Base
  has_many :tag_items
  has_many :items, through: :tag_items
end
