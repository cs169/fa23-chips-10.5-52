frozen_string_literal: true

require 'net/http'
require 'json'

class SearchCampaignController < ApplicationController
  def search
    cycle = params[:cycle]
    category = params[:category]
    
    # Access the API key from credentials
    api_key = Rails.application.credentials[:PROPUBLIC_API_KEY]

    @candidates = CampaignFinance.fetch_data(cycle, category, api_key)

    render 'campaignfinances/searchcampaign'
  end
end