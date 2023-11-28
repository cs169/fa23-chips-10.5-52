# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewsItemsController, type: :controller do
  let(:representative) { create(:representative) }
  let(:news_item) { create(:news_item, representative: representative) }

  describe 'GET #show' do
    it 'assigns the requested news item to @news_item' do
      get :show, params: { representative_id: representative.id, id: news_item.id }
      expect(assigns(:news_item)).to eq(news_item)
    end

    it 'renders the show template' do
      get :show, params: { representative_id: representative.id, id: news_item.id }
      expect(response).to render_template(:show)
    end
  end
end
