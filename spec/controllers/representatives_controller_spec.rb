# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'GET #show' do
    let(:representative) { Representative.create!(name: 'John Doe', ocdid: 'ocd1', title: 'Senator') }

    before do
      get :show, params: { id: representative.id }
    end

    it 'assigns @representative' do
      expect(assigns(:representative)).to eq(representative)
    end
  end
end
