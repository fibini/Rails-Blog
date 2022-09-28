class Post < ApplicationRecord
  has_many :likes
  belongs_to :author, class_name: 'User'
  has_many :comments

  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, numericality: { allow_nil: true, only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { allow_nil: true, only_integer: true, greater_than_or_equal_to: 0 }

  after_create :update_posts_count
  def update_posts_count
    author.increment!(:posts_counter)
  end

  def most_recent_comments
    Comment.includes(:author).where(post: self).order(created_at: :desc).limit(5)
  end
end
