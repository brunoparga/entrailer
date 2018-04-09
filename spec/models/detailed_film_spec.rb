require 'rails_helper'

RSpec.describe DetailedFilm, type: :model do
  context 'when running validations' do
    let(:aranha) { FilmTitle.create(title: 'Homem-Aranha') }
    let(:std) { Format.create(name: 'standard') }

    before do
      DetailedFilm.create(film_title: aranha, format: std, speech: 0)
    end

    it 'is not valid with a duplicate combination of film, speech and format' do
      errado = DetailedFilm.new(film_title: aranha, format: std, speech: 0)

      expect(errado.valid?).to eq false
      expect(errado.errors.details).to eq(speech: [{ error: :taken, value: 0 }])
    end

    it 'is valid when only two fields match' do
      certo = DetailedFilm.new(film_title: aranha, format: std, speech: 1)

      expect(certo.valid?).to eq true
    end
  end
end
