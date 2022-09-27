require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :system do
  describe 'show page' do
    before do
      @first_user = User.new(name: 'Fabien', photo: 'https://i.pravatar.cc/150?img=2',
                             bio: 'My name is Fabien', posts_counter: 0)
      @first_post = Post.create(title: 'My first post', text: 'Hi there', comments_counter: 0, likes_counter: 0,
                                author: @first_user)
      @first_comment = Comment.create(id: 1, text: 'This is a great post', author: @first_user, post: @first_post)
      Like.create(id: 1, author: @first_user, post: @first_post)
    end

    it 'shows the user photo, name and post count' do
      visit user_posts_path(@first_user, @first_post)
      sleep(3)
      expect(page).to have_content(@first_user.name)
      expect(page).to have_content('number of posts: 1')
      expect(page).to have_content(@first_post.title)
      expect(page).to have_content(@first_post.text)
      expect(page).to have_xpath("//img[contains(@src,'#{@first_user.photo}')]")
    end

    it 'shows the post comments, likes count and comments count' do
      visit user_posts_path(@first_user, @first_post)
      sleep(3)
      expect(page).to have_content(@first_comment.text)
      expect(page).to have_content('Comments: 1')
      expect(page).to have_content('Likes: 1')
    end

    it 'shows the post comments, likes count and comments count' do
      visit user_posts_path(@first_user, @first_post)
      sleep(3)
      expect(page).to have_content('Pagination')
      click_link @first_post.title
      expect(page).to have_current_path(user_post_path(@first_user, @first_post))
      sleep(3)
    end
  end
end
