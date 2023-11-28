# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  it 'inherits from ActiveJob::Base and can be instantiated without errors' do
    expect(described_class).to be < ActiveJob::Base
    expect { described_class.new }.not_to raise_error
  end
end
