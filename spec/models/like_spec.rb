require 'rails_helper'

RSpec.describe Like, type: :model do
    subject do
        first_user = User.new(name: "Fabien", photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio:"My name is Fabien", posts_counter: 0)
        first_post = Post.create(title: "My first post", text:"Hi there", comments_counter: 0, likes_counter: 0, author: first_user)
        Like.create(id: 1, author: first_user, post: first_post)
    end

    it 'should update likes counter' do
        expect(subject.update_post_like_counter).to be_truthy 
    end
end