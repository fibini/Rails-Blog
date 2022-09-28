require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :system do
  describe 'show page' do
    before do
      @first_user = User.new(name: 'Fabien', photo: 'https://i.pravatar.cc/150?img=2',
                             bio: 'My name is Fabien', posts_counter: 0)
      @second_user = User.new(name: 'Dino', photo: 'https://i.pravatar.cc/150?img=3',
                              bio: 'My name is Dino', posts_counter: 0)
      @first_post = Post.create(title: 'My first post', text: 'Hi there', comments_counter: 0, likes_counter: 0,
                                author: @first_user)
      @first_comment = Comment.create(id: 1, text: 'This is a great post', author: @first_user, post: @first_post)
      Like.create(id: 1, author: @first_user, post: @first_post)
      @second_comment = Comment.create(id: 2, text: 'This is a second great post', author: @second_user,
                                       post: @first_post)
    end

    it 'shows post title' do
      visit user_post_path(@first_user, @first_post)
      sleep(3)
      expect(page).to have_content(@first_post.title)
    end

    it 'shows post author' do
      visit user_post_path(@first_user, @first_post)
      sleep(3)
      expect(page).to have_content(@first_post.author.name)
    end

    it 'shows post comments_count' do
      visit user_post_path(@first_user, @first_post)
      sleep(3)
      expect(page).to have_content("Comments: #{@first_post.comments_counter}")
    end

    it 'shows post likes_count' do
      visit user_post_path(@first_user, @first_post)
      sleep(3)
      expect(page).to have_content("Likes: #{@first_post.likes_counter}")
    end

    it 'shows post body' do
      visit user_post_path(@first_user, @first_post)
      sleep(3)
      expect(page).to have_content(@first_post.text)
    end

    it 'shows username of each commentor' do
      visit user_post_path(@first_user, @first_post)
      sleep(3)
      expect(page).to have_content(@first_comment.author.name)
      expect(page).to have_content(@second_comment.author.name)
    end

    it 'shows comments of each commentor' do
      visit user_post_path(@first_user, @first_post)
      sleep(3)
      expect(page).to have_content(@first_comment.text)
      expect(page).to have_content(@second_comment.text)
    end
  end
end
