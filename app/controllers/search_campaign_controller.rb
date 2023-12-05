frozen_string_literal: true

require 'net/http'
require 'json'

class SearchCampaignController < ApplicationController
  def search
    cycle = params[:cycle]
    category = params[:category]
    api_key = '9lcjslvwVjbqtX0KcQQ3W9rFm316caQQ2T89n4xA'
    @candidates = CampaignFinance.fetch_data(cycle, category, api_key)
    render 'campaignfinances/searchcampaign'
  end
end
