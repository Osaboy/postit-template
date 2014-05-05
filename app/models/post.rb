class Post < ActiveRecord::Base
  
  include Voteable
  include Sluggable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  # the code below has been moved into the lib/voteable.rb file
  #has_many :votes, as: :voteable

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true
  validates :description, presence: true

  # moved the code below to the lib/sluggable.rb file
  # before_save :generate_slug!
  #use before_create if you don't want the slug to be regenerated

  sluggable_column :title
  
end
