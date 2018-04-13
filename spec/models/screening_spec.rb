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

      # expect(screening.valid?).to eq true
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

  context 'price function' do
    let(:aranha) { FilmTitle.new(title: 'Homem-Aranha') }
    let(:std) { Format.new(name: 'standard') }
    let(:cinemark) { Screen.new(capacity: 200) }
    let(:aranha_detailed) { DetailedFilm.new(film_title: aranha,
                                             format: std,
                                             speech: 0) }
    let(:hora) { Time.local(2018, 4, 13, 16) }
    let(:screening) do
      Screening.new(initial_tickets: 200,
                    session_time: hora,
                    closing_time: hora + 900,
                    detailed_film: aranha_detailed,
                    screen: cinemark,
                    min_price_centavos: 1000,
                    max_price_centavos: 5000)
    end

    # Stage one of testing: the function depends on time only
    # Stage two will incorporate available tickets
    describe 'returns the correct price, which' do
      it 'starts at the early bird price' do
        now = hora - 1_000_000

        expect(screening.calculate_price(now)).to eq 1000
      end

      it 'increases linearly' do
        now = hora - (297_000 + 10_800)

        expect(screening.calculate_price(now)).to eq 3000
      end

      # it 'increases exponentially in the week prior to the session' do
      #   now = hora - (86_400 + 10_800)
      #   now2 = hora - 14_400

      #   expect(screening.calculate_price(now2)).to eq 3805
      #   expect(screening.calculate_price(now)).to eq 1197
      # end

      it 'equals the maximum price 20 minutes before the session begins' do
        now = hora - 1200

        expect(screening.calculate_price(now)).to eq 5000
      end

      it 'equals the minimum price right at the session time' do
        now = hora

        expect(screening.calculate_price(now)).to eq 1000
      end

      it 'follows exponential decay in the last 15 minutes' do
        now = hora - 450

        expect(screening.calculate_price(now)).to eq 1062
      end
    end
  end
end
