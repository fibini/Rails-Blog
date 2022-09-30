require 'swagger_helper'

RSpec.describe 'api/my', type: :request do
  describe 'Blogs API' do
    path '/api/v1/users/{user_id}/posts' do
      get 'Get all posts by user ID' do
        tags 'posts'
        produces 'application/json'
        parameter name: :user_id, in: :path, type: :integer

        response '200', 'All posts found' do
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string }
                 },
                 required: %w[id title text]

          let(:user_id) { Post.create(title: 'foo', text: 'bar').id }
          run_test!
        end

        response '404', 'Not found' do
          let(:id) { 'invalid' }
          run_test!
        end

        response '406', 'Unsupported accept header' do
          let(:Accept) { 'application/foo' }
          run_test!
        end
      end
    end

    path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
      get 'Get all comments by post ID' do
        tags 'comments'
        produces 'application/json'
        parameter name: :user_id, in: :path, type: :string
        parameter name: :post_id, in: :path, type: :string

        response '200', 'all comments found' do
          schema type: :object,
                 properties: {
                   id: { type: :integer },
                   title: { type: :string },
                   text: { type: :string }
                 },
                 required: %w[id title text]

          let(:id) { Cooment.create(text: 'foo').id }
          run_test!
        end

        response '404', 'comments not found' do
          let(:id) { 'invalid' }
          run_test!
        end

        response '406', 'unsupported accept header' do
          let(:Accept) { 'application/foo' }
          run_test!
        end
      end
    end

    path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
      post 'Creates a new comment for a given post' do
        tags 'comments'
        consumes 'application/json'
        parameter name: :comment, in: :body, schema: {
          type: :object,
          properties: {
            text: { type: :string }
          },
          required: ['text']
        }

        response '201', 'comment created' do
          let(:comment) { { text: 'foo' } }
          run_test!
        end

        response '422', 'invalid request' do
          let(:comment) { { text: 'foo' } }
          run_test!
        end
      end
    end
  end
end
