# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  it 'can be instantiated without errors' do
    expect { described_class.new }.not_to raise_error
  end
end
