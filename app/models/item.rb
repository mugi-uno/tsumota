class Item < ActiveRecord::Base
  validates :relative_path, uniqueness: true

  scope :matched_keyword, -> (keyword) {
    # todo : escape like
    where('relative_path LIKE ?', "%#{keyword}%")
  }
end
