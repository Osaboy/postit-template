class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 6}

  # moved the code below to the lib/sluggable.rb file
  # before_save :generate_slug!
  #use before_create if you don't want the slug to be regenerated

  sluggable_column :username

end