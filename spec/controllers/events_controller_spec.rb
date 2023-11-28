# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET #index' do
    context 'without filter parameters' do
      it 'returns all events' do
        events = create_list(:event, 3) # Create a list of events
        get :index
        expect(assigns(:events)).to match_array(events)
      end
    end

    context 'with state-only filter' do
      it 'returns events filtered by state' do
        state = create(:state, symbol: 'NY')
        county = create(:county, state: state)
        create_list(:event, 3, county: county) # Create events in the specific state
        other_state = create(:state, symbol: 'CA')
        create_list(:event, 2, county: create(:county, state: other_state)) # Create events in a different state

        get :index, params: { 'filter-by' => 'state-only', 'state' => 'NY' }
        expect(assigns(:events)).to match_array(Event.where(county: state.counties))
      end
    end

    context 'with county filter' do
      it 'returns events filtered by county' do
        state = create(:state, symbol: 'NY')
        county = create(:county, state: state)
        create_list(:event, 3, county: county) # Create events in the specific county
        other_county = create(:county, state: state)
        create_list(:event, 2, county: other_county)  # Create events in a different county

        get :index, params: { 'filter-by' => 'county', 'state' => 'NY', 'county' => county.fips_code }
        expect(assigns(:events)).to match_array(Event.where(county: county))
      end
    end
  end
end
