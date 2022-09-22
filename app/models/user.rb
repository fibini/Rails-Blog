class User < ApplicationRecord
  has_many :comments, foreign_key: 'author_id'
  has_many :posts, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true
  validates :posts_counter, numericality: { allow_nil: true, only_integer: true, greater_than_or_equal_to: 0 }

  def recent_post
    Post.where(author: self).order(created_at: :desc).limit(3)
  end
end
