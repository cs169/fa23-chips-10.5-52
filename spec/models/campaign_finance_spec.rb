# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe CampaignFinance, type: :model do
  describe '.fetch_data' do
    let(:api_key) { 'test_api_key' }
    let(:cycle) { '2020' }
    let(:category) { 'candidate-loan' }
    let(:url) { "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json" }

    before do
      stub_request(:get, url)
        . with(headers: { 'X-API-Key' => api_key })
        .to_return(status: 200, body: { results: [{ name: 'John Doe' }] }.to_json)
    end

    it 'fetches data from the API and parses it' do
      result = CampaignFinance.fetch_data(cycle, category, api_key)
      expect(result).to eq([{ 'name' => 'John Doe' }])
    end

    context 'when the API call fails' do
      before do
        stub_request(:get, url)
          .with(headers: { 'X-API-Key' => api_key })
          .to_return(status: 500, body: {}.to_json)
      end
    
      it 'returns an empty array' do
        expect(CampaignFinance.fetch_data(cycle, category, api_key)).to eq([])
      end
    end
    
  end
end
