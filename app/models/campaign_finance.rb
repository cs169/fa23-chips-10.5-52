# frozen_string_literal: true

require 'json'
class CampaignFinance
  attr_reader :name, :party, :total_pac_contributions, 
  :total_from_individuals, :total_receipts, :state, :district, 

  def initialize(attributes={})
    @name = attributes['name']
    @party = attributes['party']
    @total_pac_contributions = attributes['total_pac_contributions']
    @total_from_individuals = attributes['total_from_individuals']
    @total_receipts = attributes['total_receipts']
    @state = attributes['state']
    @district = attributes['district']
  end

  # Method to fetch and parse the data from ProPublica API
  def self.fetch_data(cycle, category, api_key)
    url = "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json"

    uri = URI(url)

    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    puts "http.use_ssl: #{http.use_ssl?}"

    request = Net::HTTP::Get.new(uri)

    request['X-API-Key'] = api_key

    max_attempts = 2
    attempts = 0
  
    begin
      attempts += 1
      response = http.request(request)
  
      if response.code == '200'
        return JSON.parse(response.body)['results']
      else
        raise 'API request failed'
      end
    rescue => e
      puts "Attempt #{attempts}: #{e.message}"
      retry if attempts < max_attempts
      return [] # Return an empty array if all attempts fail
    end
  end
end

