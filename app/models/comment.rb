class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :update_post_comment_counter
  def update_post_comment_counter
    post.increment!(:comments_counter)
  end
end
