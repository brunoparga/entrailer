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
  .create!(title: 'Submersão',
           imdb_id: '375327',
           img_url: '/jYhm5wpUdKSWHybNS5953q8r6jk.jpg',
           banner_url: '/slkrakwwwRX7MjMWqqXMHTxLrzL.jpg',
           synopsis: 'Danielle (Alicia Vikander) é uma exploradora do oceano que descobre um novo desafio: uma terrível, porém pioneira, descida ao abismo Ártico. James (James McAvoy) é um empreiteiro acusado de ser um espião que irá se unir à moça para ajudá-la em sua missão.')
FilmTitle
  .create!(title: 'Sete Dias em Entebbe',
           imdb_id: '433627',
           img_url: '/hKbZWIMyMThZ5rXrwlImXYpXMMo.jpg',
           banner_url: '/x9JU7olOsRM4xgesgWAqMupygLT.jpg',
           synopsis: 'Em julho de 1976, um voo da Air France de Tel-Aviv a Paris foi sequestrado e forçado a pousar em Entebbe, em Uganda. Israel enviou uma missão de resgate.')
FilmTitle
  .create!(title: 'Rampage - Destruição Total',
           imdb_id: '427641',
           img_url: '/30oXQKwibh0uANGMs0Sytw3uN22.jpg',
           banner_url: '/wrqUiMXttHE4UBFMhLHlN601MZh.jpg',
           synopsis: 'O primatologista Davis Okoye (Dwayne Johnson) é um homem fechado que compartilha um vínculo inabalável com George, um gorila muito inteligente, que está sob seus cuidados desde o nascimento. ')
FilmTitle
  .create!(title: 'Com Amor, Simon',
           imdb_id: '449176',
           img_url: '/5YUYg5q7QfC4IoNwNUtiwdiYKPr.jpg',
           banner_url: '/rqMEeajyzSF4PpJtdCB816Iz8Vr.jpg',
           synopsis: 'Aos 16 anos, Simon Spier (Nick Robinson) não é abertamente gay, preferindo guardar seu drama para o musical da escola. ')
FilmTitle
  .create!(title: 'Exorcismos e Demônios',
           imdb_id: '394830',
           img_url: '/aN1drk3BqIzCUICR436t3t0lq9H.jpg',
           banner_url: '/kowMKjNYHXK3jglafTRvotMPQiS.jpg',
           synopsis: 'Quando um padre é condenado à prisão após a morte de uma freira em que praticou um exorcismo, uma jornalista investigativa se esforça para desvendar o mistério.')
FilmTitle
  .create!(title: 'O Homem das Cavernas',
           imdb_id: '387592',
           img_url: '/ugw07fJIZMVrrIGeN1MO7Xecj5h.jpg',
           banner_url: '/z30NXJEY4YDBWEL0ICHGtv4Mt26.jpg',
           synopsis: 'Se passando no início dos tempos, quando os dinossauros e mamutes ainda percorriam a face da terra, o filme conta a história de um corajoso homem das cavernas')
FilmTitle
  .create!(title: 'Um Lugar Silencioso',
           imdb_id: '447332',
           img_url: '/nAU74GmpUk7t5iklEp3bufwDq4n.jpg',
           banner_url: '/nIrDm42dy5PaXtUAzUfPmxM4mQm.jpg',
           synopsis: 'Em uma fazenda dos Estados Unidos, uma família do meio-oeste é perseguida por uma entidade fantasmagórica assustadora.')
FilmTitle
  .create!(title: 'Jogador nº 1',
           imdb_id: '333339',
           img_url: '/pU1ULUq8D3iRxl1fdX2lZIzdHuI.jpg',
           banner_url: '/q7fXcrDPJcf6t3rzutaNwTzuKP1.jpg',
           synopsis: 'Num futuro distópico, situado em 2044, Wade Watts, como o resto da humanidade, prefere a realidade virtual do jogo OASIS ao mundo real.')

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
bruno = User.create!(email: 'bruno@entrailer.com',
                     first_name: 'Bruno',
                     last_name: 'Parga',
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
paulista1 = Screen.create!(name: 'Cinemark Pátio Paulista 1',
                         address: 'Rua Treze de Maio, 1947 - São Paulo',
                         capacity: 250,
                         screen_img: 'http://img2.thejournal.ie/article/3275421/river?version=3275440&width=1340',
                         user: ownit)
cidade2 = Screen.create!(name: 'Cinemark Cidade São Paulo 2',
                         address: 'Av. Paulista, 1230, São Paulo',
                         screen_img: 'https://itpworld.files.wordpress.com/2015/12/empty-cinema-and-white-screen.jpg',
                         capacity: 50,
                         user: ownit)
reserva1 = Screen.create!(name: 'Reserva Cultural 1',
                         address: 'Av. Paulista 900',
                         screen_img: 'http://www.coop-himmelblau.at/uploads/made/uploads/images/Projects/0508_BCC/P_0508_F44_DM_1500_1004_85.jpg',
                         capacity: 180,
                         user: ownit)

reserva2 = Screen.create!(name: 'Reserva Cultural 2',
                         address: 'Av. Paulista 900',
                         screen_img: 'http://www.coop-himmelblau.at/uploads/made/uploads/images/Projects/0508_BCC/P_0508_F44_DM_1500_1004_85.jpg',
                         capacity: 180,
                         user: ownit)

reserva3 = Screen.create!(name: 'Reserva Cultural 3',
                         address: 'Av. Paulista 900',
                         screen_img: 'http://www.coop-himmelblau.at/uploads/made/uploads/images/Projects/0508_BCC/P_0508_F44_DM_1500_1004_85.jpg',
                         capacity: 180,
                         user: ownit)

cidade4 = Screen.create!(name: 'Cinemark Cidade São Paulo 4',
                         address: 'Av. Paulista, 1230, São Paulo',
                         screen_img: 'https://itpworld.files.wordpress.com/2015/12/empty-cinema-and-white-screen.jpg',
                         capacity: 50,
                         user: ownit)

paulista2 = Screen.create!(name: 'Cinemark Pátio Paulista 2',
                         address: 'Rua Treze de Maio, 1947 - São Paulo',
                         capacity: 250,
                         screen_img: 'http://img2.thejournal.ie/article/3275421/river?version=3275440&width=1340',
                         user: ownit)

puts 'Creating screen formats...'
FormatsScreen.create!(format: formats[1], screen: cidade4)
FormatsScreen.create!(format: formats[2], screen: cidade4)
FormatsScreen.create!(format: formats[1], screen: paulista2)

puts 'Creating screenings...'
screening1 = Screening.create!(screen: paulista1,
                               initial_tickets: 250,
                               session_time: DateTime.parse("20th Apr 2018 17:20:00-03:00"),      # dez minutos
                               closing_time: DateTime.parse("20th Apr 2018 17:30:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[6])
213.times { screening1.tickets << Ticket.new(purchase_time: Time.zone.now,
                                             screening: screening1,
                                             user: bruno,
                                             price_cents: 1000) }
screening1.save!

screening1a = Screening.create!(screen: paulista1,
                              initial_tickets: 250,
                              session_time: DateTime.parse("20th Apr 2018 20:15:00-03:00"),      # dez minutos
                              closing_time: DateTime.parse("20th Apr 2018 20:25:00-03:00"),
                              min_price_cents: 800,
                              max_price_cents: 3000,
                              detailed_film: films[6])
44.times { screening1a.tickets << Ticket.new(purchase_time: Time.zone.now,
                                             screening: screening1a,
                                             user: bruno,
                                             price_cents: 1000) }
screening1a.save!

screening2 = Screening.create!(screen: paulista2,
                               initial_tickets: 50,
                               session_time: DateTime.parse("20th Apr 2018 16:25:00-03:00"),  # meia semana
                               closing_time: DateTime.parse("20th Apr 2018 16:35:00-03:00"),  # + 3 horas
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[6])
26.times { screening2.tickets << Ticket.new(purchase_time: Time.zone.now,
                                             screening: screening2,
                                             user: bruno,
                                             price_cents: 1000) }
screening2.save!

screening2a = Screening.create!(screen: paulista2,
                               initial_tickets: 50,
                               session_time: DateTime.parse("20th Apr 2018 19:50:00-03:00"),  # meia semana
                               closing_time: DateTime.parse("20th Apr 2018 20:00:00-03:00"),  # + 3 horas
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[6])
 9.times { screening2a.tickets << Ticket.new(purchase_time: Time.zone.now,
                                              screening: screening2a,
                                              user: bruno,
                                              price_cents: 1000) }
screening2a.save!

screening3 = Screening.create!(screen: reserva1,
                               initial_tickets: 120,
                               session_time: DateTime.parse("20th Apr 2018 16:35:00-03:00"),     # uma hora
                               closing_time: DateTime.parse("20th Apr 2018 16:45:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[3])
36.times { screening3.tickets << Ticket.new(purchase_time: Time.zone.now,
                                             screening: screening3,
                                             user: bruno,
                                             price_cents: 1000) }
screening3.save!

screening3a = Screening.create!(screen: reserva2,
                               initial_tickets: 120,
                               session_time: DateTime.parse("20th Apr 2018 16:35:00-03:00"),     # uma hora
                               closing_time: DateTime.parse("20th Apr 2018 16:45:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[3])
109.times { screening3a.tickets << Ticket.new(purchase_time: Time.zone.now,
                                             screening: screening3a,
                                             user: bruno,
                                             price_cents: 1000) }
screening3a.save!

screening4 = Screening.create!(screen: reserva1,
                               initial_tickets: 50,
                               session_time: DateTime.parse("20th Apr 2018 20:05:00-03:00"),   # quatro horas
                               closing_time: DateTime.parse("20th Apr 2018 20:15:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[3])

24.times { screening4.tickets << Ticket.new(purchase_time: Time.zone.now,
                                             screening: screening4,
                                             user: bruno,
                                             price_cents: 1000) }
screening4.save!

screening4a = Screening.create!(screen: reserva2,
                               initial_tickets: 50,
                               session_time: DateTime.parse("20th Apr 2018 21:05:00-03:00"),     # uma hora
                               closing_time: DateTime.parse("20th Apr 2018 21:15:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[3])
 4.times { screening4a.tickets << Ticket.new(purchase_time: Time.zone.now,
                                               screening: screening4a,
                                               user: bruno,
                                               price_cents: 1000) }
screening4a.save!

screening5 = Screening.create!(screen: cidade2,
                               initial_tickets: 50,
                               session_time: DateTime.parse("20th Apr 2018 17:10:00-03:00"),   # um dia
                               closing_time: DateTime.parse("20th Apr 2018 17:20:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[8])
40.times { screening5.tickets << Ticket.new(purchase_time: Time.zone.now,
                                             screening: screening5,
                                             user: bruno,
                                             price_cents: 1000) }
screening5.save!

screening6 = Screening.create!(screen: paulista1,
                               initial_tickets: 20,
                               session_time: DateTime.parse("20th Apr 2018 23:15:00-03:00"),  # uma semana
                               closing_time: DateTime.parse("20th Apr 2018 23:25:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[4])
10.times { screening6.tickets << Ticket.new(purchase_time: Time.zone.now,
                                             screening: screening6,
                                             user: bruno,
                                             price_cents: 1000) }
screening6.save!

screening7 = Screening.create!(screen: paulista2,
                               initial_tickets: 50,
                               session_time: DateTime.parse("21st Apr 2018 14:35:00-03:00"),  # 8 dias
                               closing_time: DateTime.parse("21st Apr 2018 14:45:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[3])
47.times { screening7.tickets << Ticket.new(purchase_time: Time.zone.now,
                                             screening: screening7,
                                             user: bruno,
                                             price_cents: 1000) }
screening7.save!

screening8 = Screening.create!(screen: reserva1,
                               initial_tickets: 40,
                               session_time: DateTime.parse("21st Apr 2018 16:45:00-03:00"),      # 5 minutos
                               closing_time: DateTime.parse("21st Apr 2018 16:55:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[15])
 4.times { screening8.tickets << Ticket.new(purchase_time: Time.zone.now,
                                               screening: screening8,
                                               user: bruno,
                                               price_cents: 1000) }
screening8.save!

screening9 = Screening.create!(screen: reserva2,
                               initial_tickets: 100,
                               session_time: DateTime.parse("21st Apr 2018 19:20:00-03:00"),      # 7.5 minutos
                               closing_time: DateTime.parse("21st Apr 2018 19:30:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[14])
73.times { screening9.tickets << Ticket.new(purchase_time: Time.zone.now,
                                             screening: screening9,
                                             user: bruno,
                                             price_cents: 1000) }
screening9.save!

screening10 = Screening.create!(screen: reserva3,
                               initial_tickets: 30,
                               session_time: DateTime.parse("20th Apr 2018 16:30:00-03:00"),      # 7.5 minutos
                               closing_time: DateTime.parse("20th Apr 2018 16:40:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[6])
 2.times { screening10.tickets << Ticket.new(purchase_time: Time.zone.now,
                                               screening: screening10,
                                               user: bruno,
                                               price_cents: 1000) }
screening10.save!

screeningA = Screening.create!(screen: cidade2,
                               initial_tickets: 20,
                               session_time: DateTime.parse("21st Apr 2018 21:20:00-03:00"),      # dez minutos atrás
                               closing_time: DateTime.parse("21st Apr 2018 21:30:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[14])

 8.times { screeningA.tickets << Ticket.new(purchase_time: Time.zone.now,
                                               screening: screeningA,
                                               user: bruno,
                                               price_cents: 1000) }
screeningA.save!

screeningB = Screening.create!(screen: cidade2,
                               initial_tickets: 20,
                               session_time: DateTime.parse("22nd Apr 2018 13:20:00-03:00"),      # dez minutos atrás
                               closing_time: DateTime.parse("22nd Apr 2018 13:30:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[9])

 8.times { screeningB.tickets << Ticket.new(purchase_time: Time.zone.now,
                                               screening: screeningB,
                                               user: bruno,
                                               price_cents: 1000) }
screeningB.save!

screeningC = Screening.create!(screen: cidade4,
                               initial_tickets: 20,
                               session_time: DateTime.parse("22nd Apr 2018 17:05:00-03:00"),      # dez minutos atrás
                               closing_time: DateTime.parse("22nd Apr 2018 17:15:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[9])


 8.times { screeningC.tickets << Ticket.new(purchase_time: Time.zone.now,
                                               screening: screeningC,
                                               user: bruno,
                                               price_cents: 1000) }
screeningC.save!

screeningD = Screening.create!(screen: cidade4,
                               initial_tickets: 20,
                               session_time: DateTime.parse("22nd Apr 2018 17:35:00-03:00"),      # dez minutos atrás
                               closing_time: DateTime.parse("22nd Apr 2018 17:45:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[13])

 7.times { screeningD.tickets << Ticket.new(purchase_time: Time.zone.now,
                                               screening: screeningD,
                                               user: bruno,
                                               price_cents: 1000) }
screeningD.save!

screeningE = Screening.create!(screen: reserva3,
                               initial_tickets: 20,
                               session_time: DateTime.parse("22nd Apr 2018 17:50:00-03:00"),      # dez minutos atrás
                               closing_time: DateTime.parse("22nd Apr 2018 18:00:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[13])

 8.times { screeningE.tickets << Ticket.new(purchase_time: Time.zone.now,
                                               screening: screeningE,
                                               user: bruno,
                                               price_cents: 1000) }
screeningE.save!

screeningF = Screening.create!(screen: reserva3,
                               initial_tickets: 20,
                               session_time: DateTime.parse("23rd Apr 2018 17:10:00-03:00"),      # dez minutos atrás
                               closing_time: DateTime.parse("23rd Apr 2018 17:20:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[13])

 8.times { screeningF.tickets << Ticket.new(purchase_time: Time.zone.now,
                                               screening: screeningF,
                                               user: bruno,
                                               price_cents: 1000) }
screeningF.save!

screening10 = Screening.create!(screen: reserva3,
                               initial_tickets: 20,
                               session_time: DateTime.parse("23rd Apr 2018 20:15:00-03:00"),      # dez minutos atrás
                               closing_time: DateTime.parse("23rd Apr 2018 20:25:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[13])
 8.times { screening10.tickets << Ticket.new(purchase_time: Time.zone.now,
                                               screening: screening10,
                                               user: bruno,
                                               price_cents: 1000) }
screening10.save!

screening11 = Screening.create!(screen: cidade4,
                               initial_tickets: 45,
                               session_time: DateTime.parse("23rd Apr 2018 20:15:00-03:00"),      # dez minutos atrás
                               closing_time: DateTime.parse("23rd Apr 2018 20:25:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[11])
 8.times { screening11.tickets << Ticket.new(purchase_time: Time.zone.now,
                                               screening: screening11,
                                               user: bruno,
                                               price_cents: 1000) }
screening11.save!

screening12 = Screening.create!(screen: cidade2,
                               initial_tickets: 40,
                               session_time: DateTime.parse("23rd Apr 2018 21:30:00-03:00"),      # dez minutos atrás
                               closing_time: DateTime.parse("23rd Apr 2018 21:40:00-03:00"),
                               min_price_cents: 800,
                               max_price_cents: 3000,
                               detailed_film: films[12])

 8.times { screening12.tickets << Ticket.new(purchase_time: Time.zone.now,
                                               screening: screening12,
                                               user: bruno,
                                               price_cents: 1000) }
screening12.save!

puts 'Creating tickets...'
Ticket.create!(purchase_time: time,
                   screening: screening1,
                   user: bruno,
                   price_cents: 1640)
Ticket.create!(purchase_time: time,
                   screening: screening2,
                   user: bruno,
                   price_cents: 1370)
Ticket.create!(purchase_time: time,
                   screening: screening1,
                   user: bruno,
                   price_cents: 2240)
Ticket.create!(purchase_time: time,
                   screening: screening2,
                   user: bruno,
                   price_cents: 3100)

puts 'Done!'
