class Category < ActiveRecord::Base
 
  include Sluggable

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, 
            uniqueness: true,
            length: {minimum: 3, maximum: 20}
  
  # moved the code below to the lib/sluggable.rb file
  # before_save :generate_slug!
  #use before_create if you don't want the slug to be regenerated

  sluggable_column :name

end
