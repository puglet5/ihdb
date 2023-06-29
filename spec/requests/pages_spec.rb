# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  let(:user) { create(:user) }

  before :each do
    login_as user
  end

  describe 'GET /home to root' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end
  end
end
