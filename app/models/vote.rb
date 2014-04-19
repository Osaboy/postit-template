class Vote < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :voteable, polymorphic: true

  #using the scope parameter to limit this validation to just voteable columns
  validates_uniqueness_of :creator, scope: :voteable
  # can also do the following
  validates_uniqueness_of :creator, scope: [:voteable_id, :voteable_type]

end