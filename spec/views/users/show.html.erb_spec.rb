require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :system do
  describe 'show page' do
    before do
      @first_user = User.new(name: 'Fabien', photo: 'https://i.pravatar.cc/150?img=2',
                             bio: 'My name is Fabien', posts_counter: 0)
      @first_post = Post.create(title: 'My first post', text: 'Hi there', comments_counter: 0, likes_counter: 0,
                                author: @first_user)
      @second_post = Post.create(title: 'My second post', text: 'Yoooooo', comments_counter: 0, likes_counter: 0,
                                 author: @first_user)
      @third_post = Post.create(title: 'My third post', text: 'It is raining today', comments_counter: 0,
                                likes_counter: 0, author: @first_user)
    end
    it 'shows the user photo' do
      visit user_path(@first_user)
      sleep(3)
      expect(page).to have_xpath("//img[contains(@src,'#{@first_user.photo}')]")
    end

    it 'shows the user name' do
      visit user_path(@first_user)
      sleep(3)
      expect(page).to have_content(@first_user.name)
    end

    it 'shows the user post count' do
      visit user_path(@first_user)
      sleep(3)
      expect(page).to have_content('number of posts: 3')
    end

    it 'shows the user bio' do
      visit user_path(@first_user)
      sleep(3)
      expect(page).to have_content(@first_user.bio)
    end

    it 'shows the user recent posts' do
      visit user_path(@first_user)
      sleep(3)
      expect(@first_user.recent_post.length).to eql 3
    end

    it 'shows the see all post button' do
      visit user_path(@first_user)
      sleep(3)
      expect(page).to have_link('See all posts')
    end

    it 'redirects to the post index page' do
      visit user_path(@first_user)
      sleep(3)
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@first_user))
      sleep(3)
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
