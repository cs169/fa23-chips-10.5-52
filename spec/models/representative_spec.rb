require 'rails_helper'


RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    context 'when the representative already exists' do
      it 'does not create a duplicate representative' do
       
        existing_rep = Representative.find_or_create_by!(name: "Jamie Morgan", ocdid: "ocd1", title: "State Senator")
 
        rep_info = OpenStruct.new({
          officials: [OpenStruct.new({ name: "Jamie Morgan" })],
          offices: [OpenStruct.new({
            name: "State Senator",
            division_id: "ocd1",
            official_indices: [0]
          })]
        })
        representatives = Representative.civic_api_to_representative_params(rep_info)


        expect(representatives.count).to eq 1
        expect(Representative.count).to eq 1
        expect(representatives.first).to eq existing_rep
      end
    end




    context 'when multiple representatives are provided' do
      it 'processes each representative correctly' do
        rep_info = OpenStruct.new({
          officials: [
            OpenStruct.new({ name: "Jordan Lee" }),
            OpenStruct.new({ name: "Taylor Kim" })
          ],
          offices: [
            OpenStruct.new({ name: "Office A", division_id: "ocd2", official_indices: [0] }),
            OpenStruct.new({ name: "Office B", division_id: "ocd3", official_indices: [1] })
          ]
        })
   
        representatives = Representative.civic_api_to_representative_params(rep_info)
   
        expect(representatives.count).to eq 2
        expect(Representative.count).to eq 2
        expect(representatives.map(&:name)).to contain_exactly("Jordan Lee", "Taylor Kim")
      end
    end




    context 'when the representative data is incomplete' do
      it 'handles the scenario gracefully' do
        rep_info = OpenStruct.new({
          officials: [OpenStruct.new({ name: nil })],
          offices: [OpenStruct.new({ name: nil, division_id: nil, official_indices: [0] })]
        })
   
        expect { Representative.civic_api_to_representative_params(rep_info) }
          .not_to raise_error
      end
    end
  end
end
