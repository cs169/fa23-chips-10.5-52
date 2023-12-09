# frozen_string_literal: true

require 'rails_helper'
RSpec.describe RatingsController, type: :controller do
  let(:user) { create(:user) }
  let(:representative) { create(:representative) }
  let(:news_item) { create(:news_item, representative: representative) }

  before do
    session[:current_user_id] = user.id
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new rating and redirects with a success notice' do
        expect do
          post :create, params: { 
            representative_id: representative.id,
            news_item_id: news_item.id,
            rating: { rating: 4, news_item_id: news_item.id, user_id: user.id }
          }
        end.to change(Rating, :count).by(1)

        expect(response).to redirect_to(representative_news_item_path(representative, news_item))
        expect(flash[:notice]).to eq('Rating was successfully created.')
      end
    end

    # ... other contexts ...
  end

  # ... other tests ...
end
