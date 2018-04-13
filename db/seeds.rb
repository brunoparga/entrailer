# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This seed is based on the following version of the schema: 20180410184924

puts 'Cleaning database...'

SoldTicket.destroy_all
Screening.destroy_all
DetailedFilm.destroy_all
FilmTitle.destroy_all
FormatsScreen.destroy_all
Screen.destroy_all
Format.destroy_all
User.destroy_all

time = Time.now

puts 'Creating film titles...'
titles = ['Spider-Man', 'Inception', 'The Departed', 'Fantasia']
titles.map! { |title| FilmTitle.create!(title: title, imdb_id: rand(1..9_999)) }

puts 'Creating film formats...'
formats = %w[standard 3D IMAX]
formats.map! { |format| Format.create!(name: format) }

puts 'Creating detailed films...'
films = []
formats.each do |format|
  titles.each do |title|
    2.times do |speech|
      films << DetailedFilm.create!(film_title: title,
                                    speech: speech,
                                    format: format)
    end
  end
end

puts 'Creating users...'
roberto = User.create!(email: 'roberto@roberto.rob',
                       first_name: 'Roberto',
                       last_name: 'Barros',
                       password: 'modelosmodelos')
banana = User.create!(email: 'banana@example.com',
                      first_name: 'Banana',
                      last_name: 'Caturra',
                      password: 'senhasenha')

puts 'Creating screens...'
screen1 = Screen.create!(name: 'Cinemark Metrô Santa Cruz 3',
                         address: 'Rua Pedro de Toledo',
                         capacity: 250,
                         screen_img: 'http://img2.thejournal.ie/article/3275421/river?version=3275440&width=1340',
                         user: banana)
screen2 = Screen.create!(name: 'Espaço Itaú Augusta 5',
                         address: 'Rua Augusta',
                         screen_img: 'https://itpworld.files.wordpress.com/2015/12/empty-cinema-and-white-screen.jpg',
                         capacity: 50,
                         user: roberto)
screen3 = Screen.create!(name: 'Playarte Bristol 8',
                         address: 'Av. Paulista',
                         screen_img: 'http://www.coop-himmelblau.at/uploads/made/uploads/images/Projects/0508_BCC/P_0508_F44_DM_1500_1004_85.jpg',
                         capacity: 180,
                         user: roberto)

puts 'Creating screen formats...'
FormatsScreen.create!(format: formats[1], screen: screen1)
FormatsScreen.create!(format: formats[2], screen: screen1)
FormatsScreen.create!(format: formats[1], screen: screen3)

puts 'Creating screenings...'
screening1 = Screening.create!(screen: screen1,
                               initial_tickets: 250,
                               session_time: time,
                               closing_time: time,
                               min_price_centavos: 462,
                               max_price_centavos: 5705,
                               detailed_film: films[5])
screening2 = Screening.create!(screen: screen2,
                               initial_tickets: 50,
                               session_time: time,
                               closing_time: time,
                               min_price_centavos: 360,
                               max_price_centavos: 4750,
                               detailed_film: films[7])

puts 'Creating sold tickets...'
SoldTicket.create!(purchase_time: time,
                   screening: screening1,
                   user: roberto,
                   price_centavos: 1640)
SoldTicket.create!(purchase_time: time,
                   screening: screening2,
                   user: roberto,
                   price_centavos: 1370)
SoldTicket.create!(purchase_time: time,
                   screening: screening1,
                   user: banana,
                   price_centavos: 2240)
SoldTicket.create!(purchase_time: time,
                   screening: screening2,
                   user: banana,
                   price_centavos: 3100)

puts 'Done!'
