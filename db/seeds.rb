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

time = Time.zone.now

puts 'Creating film titles...'
FilmTitle
  .create!(title: 'Submergence',
           imdb_id: '375327',
           img_url: '/jYhm5wpUdKSWHybNS5953q8r6jk.jpg',
           banner_url: '/slkrakwwwRX7MjMWqqXMHTxLrzL.jpg',
           synopsis: 'Danielle (Alicia Vikander) é uma exploradora do oceano que descobre um novo desafio: uma terrível, porém pioneira, descida ao abismo Ártico. James (James McAvoy) é um empreiteiro acusado de ser um espião que irá se unir à moça para ajudá-la em sua missão.')
FilmTitle
  .create!(title: '7 Days in Entebbe',
           imdb_id: '433627',
           img_url: '/hKbZWIMyMThZ5rXrwlImXYpXMMo.jpg',
           banner_url: '/x9JU7olOsRM4xgesgWAqMupygLT.jpg',
           synopsis: 'Em julho de 1976, um voo da Air France de Tel-Aviv à Paris foi sequestrado e forçado a pousar em Entebbe, na Uganda.')
FilmTitle
  .create!(title: 'Rampage',
           imdb_id: '427641',
           img_url: '/30oXQKwibh0uANGMs0Sytw3uN22.jpg',
           banner_url: '/wrqUiMXttHE4UBFMhLHlN601MZh.jpg',
           synopsis: 'O primatologista Davis Okoye (Dwayne Johnson) é um homem fechado que compartilha um vínculo inabalável com George, um gorila muito inteligente, que está sob seus cuidados desde o nascimento. ')
FilmTitle
  .create!(title: 'Love, Simon',
           imdb_id: '449176',
           img_url: '/5YUYg5q7QfC4IoNwNUtiwdiYKPr.jpg',
           banner_url: '/rqMEeajyzSF4PpJtdCB816Iz8Vr.jpg',
           synopsis: 'Aos 16 anos, Simon Spier (Nick Robinson) não é abertamente gay, preferindo guardar seu drama para o musical da escola. ')
FilmTitle
  .create!(title: 'The Crucifixion',
           imdb_id: '394830',
           img_url: '/aN1drk3BqIzCUICR436t3t0lq9H.jpg',
           banner_url: '/kowMKjNYHXK3jglafTRvotMPQiS.jpg',
           synopsis: 'Quando um padre é sentenciado à prisão após a morte de uma freira em que praticou um exorcismo, uma jornalista investigativa se esforça para desvendar')
FilmTitle
  .create!(title: 'Early Man',
           imdb_id: '387592',
           img_url: '/ugw07fJIZMVrrIGeN1MO7Xecj5h.jpg',
           banner_url: '/z30NXJEY4YDBWEL0ICHGtv4Mt26.jpg',
           synopsis: 'Se passando no início dos tempos, quando os dinossauros e mamutes ainda percorriam a face da terra, Homem das Cavernas conta a história de um corajoso homem das cavernas')


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
                       confirmed_at: time)
banana = User.create!(email: 'banana@example.com',
                      first_name: 'Banana',
                      last_name: 'Caturra',
                      password: 'senhasenha',
                      confirmed_at: time)
ownit = User.create!(email: 'owner@entrailer.com',
                     role: 'theater_owner',
                     first_name: 'Owner',
                     last_name: 'Owner',
                     password: 'ownerowner',
                     cnpj: '66.768.332/0001-29',
                     address: 'R. Domingos de Morais, 2564',
                     confirmed_at: time)

puts 'Creating screens...'
screen1 = Screen.create!(name: 'Shopping Patio Paulista 1',
                         address: 'Av. Paulista, 487 - São Paulo',
                         capacity: 250,
                         screen_img: 'http://img2.thejournal.ie/article/3275421/river?version=3275440&width=1340',
                         user: ownit)
screen2 = Screen.create!(name: 'Cinemark Cidade São Paulo 1',
                         address: 'Av. Paulista, 149, São Paulo',
                         screen_img: 'https://itpworld.files.wordpress.com/2015/12/empty-cinema-and-white-screen.jpg',
                         capacity: 50,
                         user: ownit)
screen3 = Screen.create!(name: 'Reserva Cultural 1',
                         address: 'Av. Paulista 900',
                         screen_img: 'http://www.coop-himmelblau.at/uploads/made/uploads/images/Projects/0508_BCC/P_0508_F44_DM_1500_1004_85.jpg',
                         capacity: 180,
                         user: ownit)

screen4 = Screen.create!(name: 'Reserva Cultural 2',
                         address: 'Av. Paulista 900',
                         screen_img: 'http://www.coop-himmelblau.at/uploads/made/uploads/images/Projects/0508_BCC/P_0508_F44_DM_1500_1004_85.jpg',
                         capacity: 180,
                         user: ownit)

screen5 = Screen.create!(name: 'Reserva Cultural 3',
                         address: 'Av. Paulista 900',
                         screen_img: 'http://www.coop-himmelblau.at/uploads/made/uploads/images/Projects/0508_BCC/P_0508_F44_DM_1500_1004_85.jpg',
                         capacity: 180,
                         user: ownit)

screen6 = Screen.create!(name: 'Cinemark Cidade São Paulo 2',
                         address: 'Av. Paulista, 149, São Paulo',
                         screen_img: 'https://itpworld.files.wordpress.com/2015/12/empty-cinema-and-white-screen.jpg',
                         capacity: 50,
                         user: ownit)

screen7 = Screen.create!(name: 'Shopping Patio Paulista 2',
                         address: 'Av. Paulista, 487 - São Paulo',
                         capacity: 250,
                         screen_img: 'http://img2.thejournal.ie/article/3275421/river?version=3275440&width=1340',
                         user: ownit)

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
