# frozen_string_literal: true

require 'json'
class CampaignFinance
  attr_reader :name, :party, :total_pac_contributions, 
  :total_from_individuals, :total_receipts, :state, :district, 
  :committee, :status, :total_disbursements, :begin_cash, :end_cash, 
  :total_refunds, :debts_owed, :date_coverage_from, :date_coverage_to

  def initialize(attributes={})
  @name = attributes['name']
  @party = attributes['party']
  @total_pac_contributions = attributes['total_pac_contributions']
  @total_from_individuals = attributes['total_from_individuals']
  @total_receipts = attributes['total_receipts']
  @state = attributes['state']
  @district = attributes['district']
  @committee = attributes['committee']
  @status = attributes['status']
  @total_disbursements = attributes['total_disbursements']
  @begin_cash = attributes['begin_cash']
  @end_cash = attributes['end_cash']
  @total_refunds = attributes['total_refunds']
  @debts_owed = attributes['debts_owed']
  @date_coverage_from = attributes['date_coverage_from']
  @date_coverage_to = attributes['date_coverage_to']
  end

  def self.fetch_data(cycle, category, api_key)
    puts "Cycle: #{cycle}"
    puts "Category: #{category}"
    puts "API Key: #{api_key}"
    url = "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json"

    uri = URI(url)
    puts "uri: #{uri}"
    http = Net::HTTP.new(uri.host, uri.port)
    puts "http: #{http}"
    http.use_ssl = true
    puts "http.use_ssl: #{http.use_ssl?}"

    request = Net::HTTP::Get.new(uri)
    puts "request: #{request}"

    request['X-API-Key'] = api_key
    puts "request: #{request}"

    max_attempts = 2
    attempts = 0
  
    response = http.request(request)
    puts "response: #{response}"
    puts "Response body: #{response.body}"

    if response.code == '200'
      data = JSON.parse(response.body)

      data['results']
    else
      @error_message = 'Failed to fetch data'
    end
  end
end

