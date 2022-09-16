require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Fabien', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'My name is Fabien', posts_counter: 4) }

  before { subject.save }

  it 'should have name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should be an integer' do
    subject.posts_counter = 4
    expect(subject.posts_counter).to be_a(Integer)
  end
  it 'should be greater than 0' do
    subject.posts_counter = -4
    expect(subject).to_not be_valid
  end

  it 'should list three recent posts' do
    4.times do |i|
      Post.create(title: 'Hello', text: 'This is my third post', comments_counter: 0, likes_counter: 0,
                  author: subject, id: i)
    end

    expect(subject.recent_post[0].id).to eql 3
    expect(subject.recent_post.length).to eql 3
  end
end
