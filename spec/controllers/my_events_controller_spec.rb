# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyEventsController, type: :controller do
  let(:valid_attributes) do
    { name: 'New Event', county_id: create(:county).id, description: 'Event Description', start_time: Time.zone.now,
end_time: Time.zone.now + 1.hour }
  end
  let(:invalid_attributes) do
    { name: '', county_id: nil }
  end
  let(:event) { create(:event) }
  let(:user) { create(:user) }

  before do
    session[:current_user_id] = user.id
  end

  describe 'GET #new' do
    it 'assigns a new event as @event' do
      get :new
      expect(response).to render_template(:new)
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'GET #edit' do
    let(:event) { create(:event) }

    it 'assigns the requested event as @event' do
      get :edit, params: { id: event.id }
      expect(response).to render_template(:edit)
      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Event' do
        expect do
          post :create, params: { event: valid_attributes }
        end.to change(Event, :count).by(1)
      end

      it 'redirects to the events list' do
        post :create, params: { event: valid_attributes }
        expect(response).to redirect_to(events_path)
      end
    end

    context 'with invalid params' do
      it "re-renders the 'new' template" do
        post :create, params: { event: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { name: 'Updated Event Name' }
      end

      it 'updates the requested event' do
        put :update, params: { id: event.to_param, event: new_attributes }
        event.reload
        expect(event.name).to eq('Updated Event Name')
      end

      it 'redirects to the event list' do
        put :update, params: { id: event.to_param, event: new_attributes }
        expect(response).to redirect_to(events_path)
      end
    end

    context 'with invalid params' do
      it "re-renders the 'edit' template" do
        put :update, params: { id: event.to_param, event: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested event' do
      event # Create the event before the test
      expect do
        delete :destroy, params: { id: event.to_param }
      end.to change(Event, :count).by(-1)
    end

    it 'redirects to the events list' do
      delete :destroy, params: { id: event.to_param }
      expect(response).to redirect_to(events_url)
    end
  end
end
