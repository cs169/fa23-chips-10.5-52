# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginController, type: :controller do
  describe 'GET #google_oauth2' do
    it 'executes the google_oauth2 action' do
      expect(controller).to receive(:create_session).with(:create_google_user)
      get :google_oauth2, format: :json # Simulate an AJAX request format
    end
  end

  describe 'GET #github' do
    it 'executes the github action' do
      expect(controller).to receive(:create_session).with(:create_github_user)
      get :github, format: :json # Simulate an AJAX request format
    end
  end
end
