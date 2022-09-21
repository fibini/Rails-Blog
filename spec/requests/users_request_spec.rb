require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success, renders template and includes text ' do
      get '/users/index'
      expect(response).to have_http_status(:success)
      expect(response).to render_template('users/index')
      expect(response.body).to include('This page shows all users')
    end
  end

  describe 'GET /show' do
    it 'returns http success, renders template and includes text' do
      get '/users/show'
      expect(response).to have_http_status(:success)
      expect(response).to render_template('users/show')
      expect(response.body).to include('This is a specific user')
    end
  end
end
