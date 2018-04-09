require 'rails_helper'

RSpec.describe Screening, type: :model do
  context 'when validating, the initial ticket number' do

    let(:film) { FilmTitle.new(title: 'A Volta dos que Não Foram') }
    let(:screen) { Screen.new(capacity: 200) }
    let(:detailed) { DetailedFilm.new(film_title: film,
                                      speech: 0,
                                      format: screen.formats.first) }

    it "is valid when less than or equal to the screen's capacity" do
      screening = Screening.new(detailed_film: detailed,
                                screen: screen,
                                initial_tickets: 200,
                                session_time: Time.now,
                                closing_time: Time.now)

      expect(screening.valid?).to eq true
    end

    it "is not valid when greater than the screen's capacity" do
      screening = Screening.new(detailed_film: detailed,
                                screen: screen,
                                initial_tickets: 201,
                                session_time: Time.now,
                                closing_time: Time.now)

      expect(screening.valid?).to eq false
    end
  end
end
