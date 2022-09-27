require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :system do
    describe 'show page' do
        before do
            @first_user = User.new(name: 'Fabien', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80',
                bio: 'My name is Fabien', posts_counter: 0)
            @first_post = Post.create(title: 'My first post', text: 'Hi there', comments_counter: 0, likes_counter: 0, author: @first_user)
            @second_post = Post.create(title: 'My second post', text: 'Yoooooo', comments_counter: 0, likes_counter: 0, author: @first_user)
            @third_post = Post.create(title: 'My third post', text: 'It is raining today', comments_counter: 0, likes_counter: 0, author: @first_user)
        end
        it 'shows the user photo, name, post count and bio' do
            visit user_path(@first_user)
            sleep(3)
            expect(page).to have_content(@first_user.name)
            expect(page).to have_content('number of posts: 3')
            expect(page).to have_content(@first_user.bio)
            expect(page).to have_xpath("//img[contains(@src,'#{@first_user.photo}')]")
        end

        it 'shows the user recent posts' do
            visit user_path(@first_user)
            sleep(3)
            expect(@first_user.recent_post.length).to eql 3
        end

        it 'shows the see all post button and redirects to the post index page' do
            visit user_path(@first_user)
            sleep(3)
            expect(page).to have_link("See all posts")
            click_link "See all posts"
            expect(page).to have_current_path(user_posts_path(@first_user))
            sleep(4)
        end

        it 'redirects to the post show page' do
            visit user_path(@first_user)
            sleep(3)
            click_link @third_post.title
            expect(page).to have_current_path(user_post_path(@first_user, @third_post))
            sleep(3)
        end
    end
end