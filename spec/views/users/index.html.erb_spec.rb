require 'rails_helper'

RSpec.describe 'users/index.html.erb', type: :feature do
  describe 'index page' do
    before do
      @first_user = User.create(name: 'Fabien',
                                photo: 'https://i.pravatar.cc/150?img=2', bio: 'Teacher from Mexico', posts_counter: 5)
      @second_user = User.create(name: 'Richard',
                                 photo: 'https://i.pravatar.cc/150?img=2', bio: 'Teacher from Bar', posts_counter: 3)
      @third_user = User.create(name: 'Sheena',
                                photo: 'https://i.pravatar.cc/150?img=2', bio: 'Teacher from Canada', posts_counter: 1)
    end
    it 'show the user name' do
      visit users_path
      sleep(6)
      expect(page).to have_content(@first_user.name)
      expect(page).to have_content(@second_user.name)
      expect(page).to have_content(@third_user.name)
    end

    it 'show the user photo' do
      visit users_path
      sleep(4)
      expect(page).to have_xpath("//img[contains(@src,'#{@first_user.photo}')]")
      expect(page).to have_xpath("//img[contains(@src,'#{@second_user.photo}')]")
      expect(page).to have_xpath("//img[contains(@src,'#{@third_user.photo}')]")
    end

    it 'shows the user post count' do
      visit users_path
      sleep(3)
      expect(page).to have_content('number of posts: 5')
      expect(page).to have_content('number of posts: 3')
      expect(page).to have_content('number of posts: 1')
    end

    it 'redirect to user/show page' do
      visit users_path
      sleep(3)
      click_link @first_user.name
      expect(page).to have_current_path(user_path(@first_user))
      sleep(3)
    end
  end
end
