# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  it 'can be instantiated' do
    expect { described_class.new }.not_to raise_error
  end
end
