class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post #do not have to define foreign key because the assumptions are correct. Class is Post

  validates :body, presence: true
end