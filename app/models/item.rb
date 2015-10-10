class Item < ActiveRecord::Base
  validates :relative_path, uniqueness: true
end
