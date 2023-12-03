# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyNewsItemsController, type: :controller do\
  let(:user) { create(:user) }
  let(:representative) { create(:representative) }
  let(:existing_news_item) { create(:news_item, representative: representative) }

  before do
    session[:current_user_id] = user.id
  end

  describe 'GET #new' do
    before do
      mock_representative = double('Representative')
      allow(Representative).to receive(:find).with('3').and_return(mock_representative)
    end

    it 'renders the new template' do
      get :new, params: { representative_id: '3' }
      expect(response).to render_template(:new)
      expect(assigns(:news_item)).to be_a_new(NewsItem)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new news item and redirects with a success notice' do
        expect do
          post :create,
               params: { representative_id: representative.id,
                         news_item:         attributes_for(:news_item, representative_id: representative.id) }
        end.to change(NewsItem, :count).by(1)

        new_news_item = NewsItem.last
        expect(response).to redirect_to(representative_news_item_path(representative, new_news_item))
        expect(flash[:notice]).to eq('News item was successfully created.')
      end

      it 'does not create a news item and re-renders the new template' do
        post :create,
             params: { representative_id: representative.id,
                       news_item:         { title: '', description: '', link: '', issue: '' } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the news item and redirects' do
        updated_attributes = { title: 'New Title' }
        put :update,
            params: { id: existing_news_item.id, representative_id: representative.id, news_item: updated_attributes }
        expect(response).to redirect_to(representative_news_item_path(representative, existing_news_item))
        expect(flash[:notice]).to eq('News item was successfully updated.')
      end
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: existing_news_item.id, representative_id: representative.id }
      expect(response).to render_template(:edit)
      expect(assigns(:news_item)).to eq(existing_news_item)
    end
  end

  describe '#set_representatives_list' do
    it 'assigns a list of representatives' do
      create_list(:representative, 3)
      controller.send(:set_representatives_list)
      all_representatives = Representative.all.map { |r| [r.name, r.id] }
      expect(assigns(:representatives_list)).to match_array(all_representatives)
    end
  end

  describe '#set_representative' do
    it 'sets the correct representative' do
      controller.params[:representative_id] = representative.id
      controller.send(:set_representative)
      expect(assigns(:representative)).to eq(representative)
    end
  end
end
