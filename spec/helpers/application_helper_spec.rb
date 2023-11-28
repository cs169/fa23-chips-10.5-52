# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '.nav_items' do
    it 'returns an array of navigation items with correct titles and links' do
      nav_items = described_class.nav_items

      expect(nav_items).to be_an(Array)
      expect(nav_items).not_to be_empty
      expect(nav_items).to all(include(:title, :link))

      # Check the content of each nav item
      expected_nav_items = [
        { title: 'Home', link: Rails.application.routes.url_helpers.root_path },
        { title: 'Events', link: Rails.application.routes.url_helpers.events_path },
        { title: 'Representatives', link: Rails.application.routes.url_helpers.representatives_path }
      ]

      expect(nav_items).to match_array(expected_nav_items)
    end
  end
end
