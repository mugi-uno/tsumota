class Item < ActiveRecord::Base
  validates :relative_path, uniqueness: true
  has_many :tag_items
  has_many :tags, through: :tag_items

  scope :matched_keyword, -> (keyword) {
    # todo : escape like
    return nil if keyword.blank?

    keywords = keyword.split(/[\s　]/)

    items = where('relative_path LIKE ?', "%#{keywords[0]}%")

    keywords[1..-1].each do |kw|
      items = items.where('relative_path LIKE ?', "%#{kw}%")
    end

    items.page(1).per(20)
  }
end
