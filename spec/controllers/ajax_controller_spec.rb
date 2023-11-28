# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  describe 'GET #counties' do
    let(:state_symbol) { 'NY' }
    let(:state) { create(:state, symbol: state_symbol) }
    let(:counties) { [create(:county), create(:county)] }

    before do
      allow(State).to receive(:find_by).with(symbol: state_symbol.upcase).and_return(state)
      allow(state).to receive(:counties).and_return(counties)
    end

    it 'finds the state by symbol' do
      get :counties, params: { state_symbol: state_symbol }
      expect(assigns(:state)).to eq(state)
    end

    it 'renders the JSON response with counties' do
      get :counties, params: { state_symbol: state_symbol }
      expected_response = counties.to_json
      expect(response.body).to eq(expected_response)
    end
  end
end
