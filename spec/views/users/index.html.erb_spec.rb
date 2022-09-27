require 'rails_helper'

RSpec.describe 'users/index.html.erb', type: :feature do
  describe 'index page' do
    before do
      @first_user = User.create(name: 'Fabien',
                                photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80', bio: 'Teacher from Mexico', posts_counter: 5)
      @second_user = User.create(name: 'Richard',
                                 photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80', bio: 'Teacher from Barbados', posts_counter: 3)
      @third_user = User.create(name: 'Sheena',
                                photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80', bio: 'Teacher from Canada', posts_counter: 1)
    end
    it 'show the user name and show the user photo' do
      visit users_path
      sleep(6)
      expect(page).to have_content(@first_user.name)
      expect(page).to have_content(@second_user.name)
      expect(page).to have_content(@third_user.name)
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
