# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MapController, type: :controller do
  describe 'GET #index' do
    let!(:states) do
      [
        State.create!(
          symbol:       'NY',
          name:         'New York',
          fips_code:    '36',
          is_territory: false,
          lat_min:      40.0,
          lat_max:      45.0,
          long_min:     -75.0,
          long_max:     -70.0
        ),
        State.create!(
          symbol:       'CA',
          name:         'California',
          fips_code:    '06',
          is_territory: false,
          lat_min:      32.5,
          lat_max:      42.0,
          long_min:     -124.4,
          long_max:     -114.1
        )
      ]
    end

    before { get :index }

    it 'assigns @states' do
      expect(assigns(:states)).to match_array(states)
    end

    it 'assigns @states_by_fips_code' do
      expect(assigns(:states_by_fips_code)).to eq(states.index_by(&:std_fips_code))
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end
end
