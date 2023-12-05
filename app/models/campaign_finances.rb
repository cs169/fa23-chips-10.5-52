# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      office_details = process_office_details(rep_info, index)
      address_details = process_address_details(official)

      rep = Representative.find_or_initialize_by(name: official.name, ocdid: office_details[:ocdid])
      rep.assign_attributes(office_details.merge(address_details))
      rep.party = official.party if official.party
      rep.photo_url = official.photo_url if official.photo_url
      rep.save!
      reps.push(rep)
    end

    reps
  end

  def self.process_office_details(rep_info, index)
    office_details = { ocdid: '', title: '' }
    rep_info.offices.each do |office|
      if office.official_indices.include?(index)
        office_details[:title] = office.name
        office_details[:ocdid] = office.division_id
      end
    end
    office_details
  end

  def self.process_address_details(official)
    return {} unless official.address

    address = official.address.first
    {
      street: address.line1,
      city:   address.city,
      state:  address.state,
      zip:    address.zip
    }.compact
  end
end
