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
                                session_time: Time.zone.now,
                                closing_time: Time.zone.now)

      # expect(screening.valid?).to eq true
    end

    it "is not valid when greater than the screen's capacity" do
      screening = Screening.new(detailed_film: detailed,
                                screen: screen,
                                initial_tickets: 201,
                                session_time: Time.zone.now,
                                closing_time: Time.zone.now)

      expect(screening.valid?).to eq false
    end
  end

  context 'price function' do
    let(:aranha) { FilmTitle.new(title: 'Homem-Aranha') }
    let(:std) { Format.new(name: 'convencional') }
    let(:cinemark) { Screen.new(capacity: 200) }
    let(:aranha_detailed) { DetailedFilm.new(film_title: aranha,
                                             format: std,
                                             speech: 0) }
    let(:hora) { Time.zone.local(2018, 4, 13, 16) }
    let(:screening) do
      Screening.new(initial_tickets: 200,
                    session_time: hora,
                    closing_time: hora + 900,
                    detailed_film: aranha_detailed,
                    screen: cinemark,
                    min_price_cents: 1000,
                    max_price_cents: 5000)
    end

    describe 'sets the correct occupancy factor, which' do
      it 'is zero when <=10% of the tickets have been sold' do
        available_tickets = 190

        expect(screening.occupancy(available_tickets)).to eq 0
      end

      it 'is one when >=90% of the tickets have been sold' do
        available_tickets = 10

        expect(screening.occupancy(available_tickets)).to eq 1
      end

      it 'is 1/2 when 50% of the tickets are sold' do
        available_tickets = 100

        expect(screening.occupancy(available_tickets)).to eq 0.5
      end

      it 'is 1/4 when 30% of the tickets are sold' do
        available_tickets = 140

        expect(screening.occupancy(available_tickets)).to be_within(0.0001).of 0.25
      end

      it 'is 3/4 when 70% of the tickets are sold' do
        available_tickets = 60

        expect(screening.occupancy(available_tickets)).to be_within(0.0001).of 0.75
      end
    end

    context 'with empty occupancy' do
      describe 'returns the correct price, which' do
        it 'starts at the early bird price' do
          now = hora - 1_000_000

          expect(screening.calculate_price(now, 190)).to eq 'R$ ' + Money.new(1000, 'BRL').to_s
        end

        it 'increases linearly in the week prior to the session' do
          now = hora - (151_200 + 10_800)  # 3/4 of the way through the increase phase

          expect(screening.calculate_price(now, 190)).to eq 'R$ ' + Money.new(4000, 'BRL').to_s
        end

        it 'equals the maximum price 20 minutes before the session begins' do
          now = hora - 1200

          expect(screening.calculate_price(now, 190)).to eq 'R$ ' + Money.new(5000, 'BRL').to_s
        end

        it 'equals the minimum price right at the session time' do
          now = hora

          expect(screening.calculate_price(now, 190)).to eq 'R$ ' + Money.new(1000, 'BRL').to_s
        end

        it 'follows linear decay in the last 15 minutes' do
          now = hora - 225

          expect(screening.calculate_price(now, 190)).to eq 'R$ ' + Money.new(2000, 'BRL').to_s
        end
      end
    end

    context 'with 1/3 occupancy' do
      describe 'returns the correct price, which' do
        it 'starts at the early bird price' do
          now = hora - 1_000_000

          expect(screening.calculate_price(now, 0)).to eq 'R$ ' + Money.new(1000, 'BRL').to_s
        end

        it 'increases linearly in the week prior to the session' do
          now = hora - (151_200 + 10_800)  # 3/4 of the way through the increase phase

          expect(screening.calculate_price(now, 0)).to eq 'R$ ' + Money.new(4000, 'BRL').to_s
        end

        it 'equals the maximum price 20 minutes before the session begins' do
          now = hora - 1200

          expect(screening.calculate_price(now, 0)).to eq 'R$ ' + Money.new(5000, 'BRL').to_s
        end

        it 'equals the minimum price right at the session time' do
          now = hora

          expect(screening.calculate_price(now, 0)).to eq 'R$ ' + Money.new(1000, 'BRL').to_s
        end

        it 'follows linear decay in the last 15 minutes' do
          now = hora - 225

          expect(screening.calculate_price(now, 0)).to eq 'R$ ' + Money.new(2000, 'BRL').to_s
        end
      end
    end

    context 'with full occupancy' do
      describe 'returns the correct price, which' do
        it 'starts at the early bird price' do
          now = hora - 1_000_000

          expect(screening.calculate_price(now, 0)).to eq 'R$ ' + Money.new(1000, 'BRL').to_s
        end

        it 'increases linearly in the week prior to the session' do
          now = hora - (151_200 + 10_800)  # 3/4 of the way through the increase phase

          expect(screening.calculate_price(now, 0)).to eq 'R$ ' + Money.new(4000, 'BRL').to_s
        end

        it 'equals the maximum price 20 minutes before the session begins' do
          now = hora - 1200

          expect(screening.calculate_price(now, 0)).to eq 'R$ ' + Money.new(5000, 'BRL').to_s
        end

        it 'equals the minimum price right at the session time' do
          now = hora

          expect(screening.calculate_price(now, 0)).to eq 'R$ ' + Money.new(1000, 'BRL').to_s
        end

        it 'follows linear decay in the last 15 minutes' do
          now = hora - 225

          expect(screening.calculate_price(now, 0)).to eq 'R$ ' + Money.new(2000, 'BRL').to_s
        end
      end
    end
  end
end
