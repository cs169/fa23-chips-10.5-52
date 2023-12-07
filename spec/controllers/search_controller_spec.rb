# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'POST #search' do
    let(:address) { '123 Main Street' }
    let(:api_result) { double('api_result') }
    let(:representatives) { [double('representative')] }

    before do
      allow_any_instance_of(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:key=)
      allow_any_instance_of(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:representative_info_by_address).and_return(api_result)
      allow(Representative).to receive(:civic_api_to_representative_params).and_return(representatives)
    end

    it 'sets the @representatives variable' do
      post :search, params: { address: address }
      expect(assigns(:representatives)).to eq(representatives)
    end

    it 'renders the search template for representatives' do
      post :search, params: { address: address }
      expect(response).to render_template('representatives/search')
    end
  end
end
