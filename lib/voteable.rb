module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable
  end

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size 
  end

  def down_votes
    self.votes.where(vote: false).size 
  end

end

# Using normal metaprogramming
=begin 
module Voteable

  def self.included(base)
    # this is the callback that will be fired when you include the voteable module in your model
    base.send(:include, InstanceMethods) #included as instance variables
    base.extend ClassMethods
    base.class_eval do 
      my_class_method
    end
  end

  module InstanceMethods

    def total_votes
      up_votes - down_votes
    end

    def up_votes
      self.votes.where(vote: true).size 
    end

    def down_votes
      self.votes.where(vote: false).size 
    end

  end

  module ClassMethods
    def my_class_method
      has_many :votes, as: :voteable
    end
  end

end
=end
