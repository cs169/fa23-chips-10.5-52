# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do
  describe 'GET #new' do
    it 'assigns a new news item to @news_item' do
      get :new
      expect(assigns(:news_item)).to be_a_new(NewsItem)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end
