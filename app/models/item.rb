class Item < ActiveRecord::Base
  validates :relative_path, uniqueness: true
  has_many :tag_items
  has_many :tags, through: :tag_items
  accepts_nested_attributes_for :tag_items, :allow_destroy => true

  scope :matched_keyword, -> (keyword) {
    # todo : escape like
    items = Item.all
    keywords = keyword.to_s.split(/[\s　]/)

    keywords[0..-1].each do |kw|
      next if kw == ":"

      if kw.start_with?(":")
        tagname = kw[1..-1]
        items = items.includes(:tags).where('tags.name = ?', "#{tagname}").references(:tags)
      else
        items = items.where('relative_path LIKE ?', "%#{kw}%")
      end
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
