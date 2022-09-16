require 'rails_helper'

RSpec.describe Post, type: :model do
  subject do
    first_user = User.new(name: 'Fabien', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                          bio: 'My name is Fabien', posts_counter: 0)
    Post.create(title: 'My first post', text: 'Hi there', comments_counter: 0, likes_counter: 0, author: first_user)
  end

  before { subject.save }

  it 'should have title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'should not be greater than 250' do
    subject.title = 'a' * 250
    expect(subject).to be_valid
  end

  it 'should be an integer' do
    subject.comments_counter = 4
    expect(subject.comments_counter).to be_a(Integer)
  end
  it 'should be greater than 0' do
    subject.comments_counter = -4
    expect(subject).to_not be_valid
  end

  it 'should be an integer' do
    subject.likes_counter = 4
    expect(subject.likes_counter).to be_a(Integer)
  end
  it 'should be greater than 0' do
    subject.likes_counter = -4
    expect(subject).to_not be_valid
  end

  it 'should update post counter' do
    expect(subject.author.posts_counter).to eq 1
  end

  it 'should list five recent comments' do
    6.times do |i|
      Comment.create(post: subject, author: subject.author, text: 'Hi Tom!', id: i)
    end

    expect(subject.most_recent_comments[0].id).to eql 5
    expect(subject.most_recent_comments.length).to eql 5
  end
end
