module Sluggable

  extend ActiveSupport::Concern
  included do
    before_save :generate_slug!
    class_attribute :slug_column
  end

  def to_param
    self.slug
  end
  
  # ! to denote a destructive action
  def generate_slug!
    the_slug = to_slug(self.send(self.class.slug_column.to_sym)) #self.title or self.name or self.username
    #Instead of User.class.find_by
    obj = self.class.find_by(slug: the_slug)
    count = 2
    while obj && obj != self # don't want to append for an existing user object, 
    # e.g while editing and updating
      the_slug = append_suffix(the_slug, count)
      obj = self.class.find_by(slug: the_slug)
      count += 1
    end
    self.slug = the_slug.downcase
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s
    else
      return str + "-" + count.to_s
    end
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/,"-"
    str.downcase
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end

end