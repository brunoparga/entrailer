require 'rails_helper'

RSpec.describe DetailedFilm, type: :model do
  context 'when running validations' do
    it 'is not valid with a duplicate combination of film, speech and format' do
      aranha = FilmTitle.create(title: 'Homem-Aranha')
      format = 1
      DetailedFilm.create(film_title: aranha, format_id: format, speech: 0)

      errado = DetailedFilm.new(film_title: aranha, format_id: format, speech: 0)

      expect(errado.valid?).to eq false
    end
  end
end
