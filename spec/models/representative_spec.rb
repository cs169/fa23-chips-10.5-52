# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    let(:existing_rep_info) do
      OpenStruct.new({
                       officials: [OpenStruct.new({ name: 'Jamie Morgan' })],
                       offices:   [OpenStruct.new({
                                                    name:             'State Senator',
                                                    division_id:      'ocd1',
                                                    official_indices: [0]
                                                  })]
                     })
    end

    context 'when the representative already exists' do
      let!(:existing_rep) { described_class.create!(name: 'Jamie Morgan', ocdid: 'ocd1', title: 'State Senator') }

      before do
        @representatives = described_class.civic_api_to_representative_params(existing_rep_info)
      end

      it 'does not create a duplicate representative' do
        expect(@representatives.count).to eq 1
        expect(@representatives.first).to eq existing_rep
      end

      it 'does not increase the total count of representatives' do
        expect(described_class.count).to eq 1
      end

      it 'returns the existing representative' do
        expect(@representatives.first).to eq existing_rep
      end

      it 'returns only one representative' do
        expect(@representatives.count).to eq 1
      end
    end

    context 'when multiple representatives are provided' do
      let(:multi_rep_info) do
        OpenStruct.new({
                         officials: [
                           OpenStruct.new({ name: 'Jordan Lee' }),
                           OpenStruct.new({ name: 'Taylor Kim' })
                         ],
                         offices:   [
                           OpenStruct.new({ name: 'Office A', division_id: 'ocd2', official_indices: [0] }),
                           OpenStruct.new({ name: 'Office B', division_id: 'ocd3', official_indices: [1] })
                         ]
                       })
      end

      before do
        @representatives = described_class.civic_api_to_representative_params(multi_rep_info)
      end

      it 'processes each representative correctly' do
        expect(@representatives.map(&:name)).to contain_exactly('Jordan Lee', 'Taylor Kim')
      end

      it 'increases the total count of representatives correctly' do
        expect(described_class.count).to eq 2
      end
    end

    context 'when the representative data is incomplete' do
      let(:incomplete_rep_info) do
        OpenStruct.new({
                         officials: [OpenStruct.new({ name: nil })],
                         offices:   [OpenStruct.new({ name: nil, division_id: nil, official_indices: [0] })]
                       })
      end

      it 'handles the scenario gracefully' do
        expect { described_class.civic_api_to_representative_params(incomplete_rep_info) }
          .not_to raise_error
      end
    end
  end

  describe 'attributes' do
    let(:representative) do
      described_class.create!(
        name:      'John Doe',
        ocdid:     'ocd1',
        title:     'Senator',
        street:    '123 Main St',
        city:      'Anytown',
        state:     'Anystate',
        zip:       '12345',
        party:     'Independent',
        photo_url: 'http://example.com/photo.jpg'
      )
    end

    it 'has a correct name' do
      expect(representative.name).to eq('John Doe')
    end

    it 'has a correct title' do
      expect(representative.title).to eq('Senator')
    end

    it 'has correct address details' do
      expect(representative.street).to eq('123 Main St')
      expect(representative.city).to eq('Anytown')
      expect(representative.state).to eq('Anystate')
      expect(representative.zip).to eq('12345')
    end

    it 'has correct party information' do
      expect(representative.party).to eq('Independent')
    end

    it 'has correct photo url' do
      expect(representative.photo_url).to eq('http://example.com/photo.jpg')
    end
  end
end
