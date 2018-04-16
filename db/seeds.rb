# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This seed is based on the following version of the schema: 20180414225041

puts 'Cleaning database...'

Ticket.destroy_all
Screening.destroy_all
DetailedFilm.destroy_all
FilmTitle.destroy_all
FormatsScreen.destroy_all
Screen.destroy_all
Format.destroy_all
User.destroy_all

time = Time.now

puts 'Creating film titles...'
FilmTitle
  .create!(title: 'Spider-Man',
           imdb_id: '557',
           img_url: '/rZd0y1X1Gw4t5B3f01Qzj8DYY66.jpg',
           banner_url: '/5yAEbTXiJZQpNx7eCyyOhnY9MYw.jpg',
           synopsis: 'Homem-Aranha, Homem-Aranha: nunca bate, só apanha')
FilmTitle
  .create!(title: 'The Departed',
           imdb_id: '1422',
           img_url: '/tGLO9zw5ZtCeyyEWgbYGgsFxC6i.jpg',
           banner_url: '/8Od5zV7Q7zNOX0y9tyNgpTmoiGA.jpg',
           synopsis: 'Dois infiltrados, um tenta pegar o outro, um acaba pegando a mina do outro')
FilmTitle
  .create!(title: 'Inception',
           imdb_id: '27205',
           img_url: '/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg',
           banner_url: '/s2bT29y0ngXxxu2IA8AOzzXTRhd.jpg',
           synopsis: 'Temos que ir mais fundo!! *Buóóóin*')
FilmTitle
  .create!(title: 'Fantasia',
           imdb_id: '756',
           img_url: '/dYZ1r3MJnXVGBBSYKgpd8UWGyFw.jpg',
           banner_url: '/oZBj2o3JVULRe1SlBalBpnkfp6x.jpg',
           synopsis: 'Melhor metáfora de inteligência artificial que há')
FilmTitle
  .create!(title: 'Friday the 13th',
           imdb_id: '13207',
           img_url: '/ewNYItHBmxHj3IEDhj1VnnLoTmb.jpg',
           banner_url: '/m7vZl6YTFIHm917fCBgNOb9c4Sp.jpg',
           synopsis: 'Cuidado, ele vai te pegar!')
FilmTitle
  .create!(title: 'Freddy vs. Jason',
           imdb_id: '6466',
           img_url: '/smD9JEIKuvsllgjgrGTOzzbATeN.jpg',
           banner_url: '/pHPi34ysBhhLVM9LVKwJ0nJPFqN.jpg',
           synopsis: 'O crossover mais ambicioso da história')
FilmTitle
  .create!(title: 'Friday the 13th Part VIII: Jason Takes Manhattan',
           imdb_id: '10283',
           img_url: '/oAZTwZDHu56IUyq5OQM3q1xX9To.jpg',
           banner_url: '/pCTwz9ggIcfHTQrzb1xi3UQLPxb.jpg',
           synopsis: 'Olha, dessa vez é sério, ele vai te pegar mesmo hein')
FilmTitle
  .create!(title: 'Demon in the Freezer',
           imdb_id: '397973',
           img_url: '/1AD6EIKrWsiuRdyeTkBZW9iIu8w.jpg',
           banner_url: '/dMU9M4RYi9DOnaebljtjSt0BSXm.jpg',
           synopsis: 'Sabe aquele frango que você botou pra congelar e esqueceu?')

puts 'Creating film formats...'
formats = %w[convencional 3D IMAX]
formats.map! { |format| Format.create!(name: format) }

puts 'Creating detailed films...'
films = []
titles = FilmTitle.all
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
                       password: 'modelosmodelos',
                       confirmed_at: Time.now)
banana = User.create!(email: 'banana@example.com',
                      first_name: 'Banana',
                      last_name: 'Caturra',
                      password: 'senhasenha',
                      confirmed_at: Time.now)
ownit = User.create!(email: 'owner@entrailer.com',
                     role: 'theater_owner',
                     first_name: 'Owner',
                     last_name: 'Owner',
                     password: 'ownerowner',
                     confirmed_at: Time.now)

puts 'Creating screens...'
screen1 = Screen.create!(name: 'Cinemark Metrô Santa Cruz 3',
                         address: 'Rua Pedro de Toledo 125',
                         capacity: 250,
                         screen_img: 'http://img2.thejournal.ie/article/3275421/river?version=3275440&width=1340',
                         user: banana)
screen2 = Screen.create!(name: 'Espaço Itaú Augusta 5',
                         address: 'Rua Augusta 920',
                         screen_img: 'https://itpworld.files.wordpress.com/2015/12/empty-cinema-and-white-screen.jpg',
                         capacity: 50,
                         user: roberto)
screen3 = Screen.create!(name: 'Playarte Bristol 8',
                         address: 'Av. Paulista 1405',
                         screen_img: 'http://www.coop-himmelblau.at/uploads/made/uploads/images/Projects/0508_BCC/P_0508_F44_DM_1500_1004_85.jpg',
                         capacity: 180,
                         user: roberto)

screen4 = Screen.create!(name: 'Playarte Bristol 5',
                         address: 'Av. Paulista 1405',
                         screen_img: 'http://www.coop-himmelblau.at/uploads/made/uploads/images/Projects/0508_BCC/P_0508_F44_DM_1500_1004_85.jpg',
                         capacity: 180,
                         user: roberto)

screen5 = Screen.create!(name: 'Playarte Bristol 2',
                         address: 'Av. Paulista 1405',
                         screen_img: 'http://www.coop-himmelblau.at/uploads/made/uploads/images/Projects/0508_BCC/P_0508_F44_DM_1500_1004_85.jpg',
                         capacity: 180,
                         user: roberto)

screen6 = Screen.create!(name: 'Espaço Itaú Augusta 2',
                         address: 'Rua Augusta 920',
                         screen_img: 'https://itpworld.files.wordpress.com/2015/12/empty-cinema-and-white-screen.jpg',
                         capacity: 50,
                         user: roberto)

screen7 = Screen.create!(name: 'Cinemark Metrô Santa Cruz 1',
                         address: 'Rua Pedro de Toledo 125',
                         capacity: 250,
                         screen_img: 'http://img2.thejournal.ie/article/3275421/river?version=3275440&width=1340',
                         user: banana)

puts 'Creating screen formats...'
FormatsScreen.create!(format: formats[1], screen: screen1)
FormatsScreen.create!(format: formats[2], screen: screen1)
FormatsScreen.create!(format: formats[1], screen: screen3)

puts 'Creating screenings...'
screening1 = Screening.create!(screen: screen1,
                               initial_tickets: 250,
                               session_time: time + 600,      # dez minutos
                               closing_time: time + 600,
                               min_price_cents: 462,
                               max_price_cents: 5705,
                               detailed_film: films[6])
screening2 = Screening.create!(screen: screen2,
                               initial_tickets: 50,
                               session_time: time + 306_000,  # meia semana
                               closing_time: time + 306_000,  # + 3 horas
                               min_price_cents: 360,
                               max_price_cents: 4750,
                               detailed_film: films[1])
screening3 = Screening.create!(screen: screen3,
                               initial_tickets: 120,
                               session_time: time + 3600,     # uma hora
                               closing_time: time + 3600,
                               min_price_cents: 360,
                               max_price_cents: 3200,
                               detailed_film: films[3])
screening4 = Screening.create!(screen: screen4,
                               initial_tickets: 50,
                               session_time: time + 14_400,   # quatro horas
                               closing_time: time + 14_400,
                               min_price_cents: 340,
                               max_price_cents: 6000,
                               detailed_film: films[10])
screening5 = Screening.create!(screen: screen5,
                               initial_tickets: 50,
                               session_time: time + 86_400,   # um dia
                               closing_time: time + 86_400,
                               min_price_cents: 360,
                               max_price_cents: 8200,
                               detailed_film: films[8])
screening6 = Screening.create!(screen: screen6,
                               initial_tickets: 20,
                               session_time: time + 604_800,  # uma semana
                               closing_time: time + 604_800,
                               min_price_cents: 1120,
                               max_price_cents: 4000,
                               detailed_film: films[2])
screening7 = Screening.create!(screen: screen7,
                               initial_tickets: 50,
                               session_time: time + 691_200,  # 8 dias
                               closing_time: time + 691_200,
                               min_price_cents: 730,
                               max_price_cents: 3750,
                               detailed_film: films[10])
screening8 = Screening.create!(screen: screen1,
                               initial_tickets: 40,
                               session_time: time + 300,      # 5 minutos
                               closing_time: time + 300,
                               min_price_cents: 360,
                               max_price_cents: 4750,
                               detailed_film: films[15])
screening9 = Screening.create!(screen: screen3,
                               initial_tickets: 100,
                               session_time: time + 450,      # 7.5 minutos
                               closing_time: time + 450,
                               min_price_cents: 120,
                               max_price_cents: 4750,
                               detailed_film: films[14])
screeningA = Screening.create!(screen: screen5,
                               initial_tickets: 20,
                               session_time: time - 600,      # dez minutos atrás
                               closing_time: time - 600,
                               min_price_cents: 400,
                               max_price_cents: 4750,
                               detailed_film: films[9])

puts 'Creating tickets...'
Ticket.create!(purchase_time: time,
                   screening: screening1,
                   user: roberto,
                   price_cents: 1640)
Ticket.create!(purchase_time: time,
                   screening: screening2,
                   user: roberto,
                   price_cents: 1370)
Ticket.create!(purchase_time: time,
                   screening: screening1,
                   user: banana,
                   price_cents: 2240)
Ticket.create!(purchase_time: time,
                   screening: screening2,
                   user: banana,
                   price_cents: 3100)

puts 'Done!'
