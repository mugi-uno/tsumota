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


  def tags_csv
    tags.map {|tag| tag.name }.join(",")
  end

  def import_tags_csv(csv)
    return self if csv.blank?

    csv.split(",")
    .uniq
    .sort! {|tag1, tag2| tag1 <=> tag2}
    .each {|name|
      tags << Tag.find_or_create_by(name: name)
    }

    self
  end
end
