require 'rails_helper'

RSpec.describe Screen, type: :model do
  context 'when initializing' do
    it "builds the 'convencional' format" do
      screen = Screen.new

      expect(screen.formats).not_to be_empty
      expect(screen.formats.first.name).to eq 'convencional'
    end
  end
end
