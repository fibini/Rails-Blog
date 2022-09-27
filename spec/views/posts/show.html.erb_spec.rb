require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :system do
    describe 'show page' do
        before do
            @first_user = User.new(name: 'Fabien', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80',
                bio: 'My name is Fabien', posts_counter: 0)
            @second_user = User.new(name: 'Dino', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80',
                bio: 'My name is Dino', posts_counter: 0)
            @first_post = Post.create(title: 'My first post', text: 'Hi there', comments_counter: 0, likes_counter: 0, author: @first_user)
            @first_comment = Comment.create(id: 1, text: 'This is a great post', author: @first_user, post: @first_post)
            Like.create(id: 1, author: @first_user, post: @first_post)
            @second_comment = Comment.create(id: 2, text: 'This is a second great post', author: @second_user, post: @first_post)
           
        end

        it 'shows post title, post author, comments_count, likes_count' do
            visit user_post_path(@first_user, @first_post)
            sleep(3)
            expect(page).to have_content(@first_post.title)
            expect(page).to have_content(@first_post.author.name)
            expect(page).to have_content("Comments: #{@first_post.comments_counter}")
            expect(page).to have_content("Likes: #{@first_post.likes_counter}")
        end

        it 'shows post body, username of each commentor and comments' do
            visit user_post_path(@first_user, @first_post)
            sleep(3)
            expect(page).to have_content(@first_post.text)
            expect(page).to have_content(@first_comment.author.name)
            expect(page).to have_content(@second_comment.author.name)
            expect(page).to have_content(@first_comment.text)
            expect(page).to have_content(@second_comment.text)
        end

    end
end