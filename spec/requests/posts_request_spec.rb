require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success, renders template and includes text' do
      get '/posts/index'
      expect(response).to have_http_status(:success)
      expect(response).to render_template('posts/index')
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET /show' do
    it 'returns http success, renders template and includes text' do
      get '/posts/show'
      expect(response).to have_http_status(:success)
      expect(response).to render_template('posts/show')
      expect(response.body).to include('This shows a specific post for a specific user')
    end
  end
end
