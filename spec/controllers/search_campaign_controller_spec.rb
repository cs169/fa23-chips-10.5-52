# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchCampaignController, type: :controller do
  describe "GET #search" do
    before do
      allow(CampaignFinance).to receive(:fetch_data).and_return([{name: 'John Doe', party: 'Independent'}])
    end

    it "responds successfully" do
      get :search, params: { cycle: '2020', category: 'candidate-loan' }
      expect(response).to be_successful
    end

    it "renders the searchcampaign template" do
      get :search, params: { cycle: '2020', category: 'candidate-loan' }
      expect(response).to render_template('campaignfinances/searchcampaign')
    end

    it "assigns @candidates" do
      get :search, params: { cycle: '2020', category: 'candidate-loan' }
      expect(assigns(:candidates)).not_to be_nil
    end
  end
end