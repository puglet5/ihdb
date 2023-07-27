# frozen_string_literal: true

RSpec.describe '/posters', type: :request do
  let(:user) { create(:user) }

  let(:valid_attributes) do
    {
      'title' => 'Test Poster',
      'user_id' => user.id
    }
  end

  let(:invalid_attributes) do
    {
      'title' => nil,
      'user_id' => user.id
    }
  end

  before :each do
    login_as user
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Poster.create! valid_attributes
      get posters_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      poster = Poster.create! valid_attributes
      get poster_url(id: poster.id)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_poster_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      poster = Poster.create! valid_attributes
      get edit_poster_url(id: poster.id)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Poster' do
        expect do
          post posters_url, params: { poster: valid_attributes }
        end.to change(Poster, :count).by(1)
      end

      it 'redirects to the created poster' do
        post posters_url, params: { poster: valid_attributes }
        expect(response).to redirect_to(poster_url(Poster.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Poster' do
        expect do
          post posters_url, params: { poster: invalid_attributes }
        end.to change(Poster, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template with 422 response (turbo))" do
        post posters_url, params: { poster: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { 'title' => 'Updated Test Poster' }
      end

      it 'updates the requested poster' do
        poster = Poster.create! valid_attributes
        patch poster_url(id: poster.id), params: { poster: new_attributes }
        poster.reload
        expect(poster.attributes).to include({ 'title' => 'Updated Test Poster' })
      end

      it 'redirects to the poster' do
        poster = Poster.create! valid_attributes
        patch poster_url(id: poster.id), params: { poster: new_attributes }
        poster.reload
        expect(response).to redirect_to(poster_url(id: poster.id))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template with 422 response (turbo))" do
        poster = Poster.create! valid_attributes
        patch poster_url(id: poster.id), params: { poster: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested poster' do
      poster = Poster.create! valid_attributes
      expect do
        delete poster_url(id: poster.id)
      end.to change(Poster, :count).by(-1)
    end

    it 'redirects to the posters list' do
      poster = Poster.create! valid_attributes
      delete poster_url(id: poster.id)
      expect(response).to redirect_to(posters_url)
    end
  end
end
