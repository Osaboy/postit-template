class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, 
            uniqueness: true,
            length: {minimum: 3, maximum: 20}
  
  before_save :generate_slug!

  def to_param
    self.slug
  end
  
  # ! to denote a destructive action
  def generate_slug!
    the_slug = to_slug(self.name)
    category = Category.find_by(slug: the_slug)
    count = 2
    while category && post != self # don't want to append for an existing category object, 
    # e.g while editing and updating
      the_slug = append_slug(the_slug, count)
      category = Category.find_by(slug: the_slug)
      count += 1
    end
    self.slug = the_slug.downcase
  end

  def append_slug(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s
    else
      return str + "-" + count.to_s
    end
  end

  def to_slug(str)
    str = str.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/,"-"
    str.downcase
  end

end
