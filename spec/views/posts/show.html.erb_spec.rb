require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :system do
    describe 'show page' do
        before do
            @first_user = User.new(name: 'Fabien', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80',
                bio: 'My name is Fabien', posts_counter: 0)
            @first_post = Post.create(title: 'My first post', text: 'Hi there', comments_counter: 0, likes_counter: 0, author: @first_user)
            @first_comment = Comment.create(id: 1, text: 'This is a great post', author: @first_user, post: @first_post)
            Like.create(id: 1, author: @first_user, post: @first_post)
        end
    end
end