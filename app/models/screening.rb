class Screening < ApplicationRecord
  belongs_to :detailed_film
  belongs_to :screen
  has_many :tickets

  validates :session_time,
            presence: true,
            uniqueness: { scope: %i[detailed_film_id screen_id] }
  validates :closing_time, presence: true
  validates :initial_tickets, presence: true
  validate :initial_tickets_must_be_lte_screen_capacity
  validate :screen_must_have_film_format

  monetize :min_price_cents, as: :min_price
  monetize :max_price_cents, as: :max_price

  scope :past, -> (date) { where('screenings.session_time <= ?', date) }
  scope :open, -> (date) { where('screenings.session_time > ?', date) }

  include PgSearch
  pg_search_scope :search_by_session_time,
    against: [ :session_time ],
    using: {
      tsearch: { prefix: true }
    }

  def title
    detailed_film.title
  end

  def self.pick_four
    # The array that will be returned
    four = []

    # Get all screenings whose time is before 01:00 tomorrow
    screenings_today = self.where('screenings.session_time <= ?', Time.zone.tomorrow.midnight + 3600 )

    # Populate a hash with the number of screenings of each film
    screenings_by_title = Hash.new(0)
    screenings_today.each do |scg|
      screenings_by_title[scg.detailed_film.title] += 1
    end

    # An array of the top four film titles by number of screenings
    top_four_titles = screenings_by_title.sort[0..3]
    top_four_titles.map! { |array| array[0] }

    # Screening list discards screenings whose films are not in the top 4
    screenings_today = screenings_today.select { |scg| top_four_titles.include?(scg.detailed_film.title) }

    # For all films in the top 4, pair each screening with its current price (an Integer)
    screenings_with_prices = {}
    screenings_today.each do |scg|
      screenings_with_prices[scg] = scg.calculate_price(Time.zone.now, scg.initial_tickets - scg.tickets.count).match(/(\d+,\d{0,2})/)[1].sub(',', '').to_i
    end

    # Push the four cheapest screenings (of different films) onto the return array
    screenings_with_prices = screenings_with_prices.sort
    four_titles = []
    screenings_with_prices.each do |array|
      unless four_titles.include? array[0].title
        four << array[0]
        four_titles << array[0].title
      end
      break if four.length == 4
    end
    four
  end

  def formatted_date
    session_date = Date.new(session_time.year, session_time.month, session_time.day)
    now = Time.zone.now
    todays_date = Date.new(now.year, now.month, now.day)
    date = case session_date
    when todays_date then 'hoje'
    when todays_date + 1 then 'amanhã'
    else session_date.strftime('%d/%m')
    end
    date
  end

  def formatted_time
    session_time.strftime('%H:%M')
  end

  def calculate_price(purchase_time, available_tickets)
    # purchase_time is the time the controller calls this method
    # returns a price in centavos as an integer

    # TODO: use closing time, include it in the price decay period?.
    # TODO?: change the increase and decay from exponential to logistic/tanh?
    # TODO?: Prices start increasing between a week and two weeks (+ 3 hours) before session
    # increase_start: -615_600 - 604_800 * occupancy,

    occupancy = occupancy(available_tickets)

    price_params =
      { # Prices finish decaying at session time
        decay_end: 0,
        # Prices start decaying 15 to 5 minutes before session, depending on occupancy
        decay_start: -900 + 600 * occupancy,
        # Prices start increasing a week and 3 hours before session
        increase_start: -615_600,
        # Prices peak between 2 and 4 hours before session
        max_start: -7200 - 7200 * occupancy,
        # Prices are this times the minimum before they start rising
        early_bird_factor: 1 }

    # How long between now and session time?
    # This is a negative number as long as purchase is before session
    interval = purchase_time - session_time
    Money
      .new(price_calculator(interval, price_params), 'BRL')
      .format(symbol_before_without_space: false)
  end

  private

  def occupancy(available_tickets)
    fraction = 1 - (available_tickets / initial_tickets.to_f)
    case fraction
    when -> (n) { n <= 0.1 } then return 0.0
    when -> (n) { n >= 0.9 } then return 1.0
    else return (fraction - 0.1) * 1.25
    end
  end

  def price_calculator(interval, price_params)
    # interval: the duration between reference time and session start time
    # price_params are set at #calculate_price
    # returns the correct price in centavos
    return min_price_cents if interval.positive?

    if interval >= price_params[:decay_start]
      return linear(interval,
                    max_price_cents,
                    min_price_cents,
                    price_params[:decay_start],
                    price_params[:decay_end])
    end

    return max_price_cents if interval >= price_params[:max_start]

    early_bird = min_price_cents * price_params[:early_bird_factor]
    if interval >= price_params[:increase_start]
      return linear(interval,
                    early_bird,
                    max_price_cents,
                    price_params[:increase_start],
                    price_params[:max_start])
    end

    return early_bird
  end

  def linear(interval, start_price, end_price, start_time, end_time)
    duration = end_time - start_time
    # proportion is <1 because interval is a negative number
    proportion = 1 + ((interval - end_time) / duration)
    price_range = end_price - start_price
    start_price + (proportion * price_range).round
  end

  def initial_tickets_must_be_lte_screen_capacity
    if initial_tickets > screen.capacity
      errors.add(:initial_tickets, "must be <= screen capacity")
    end
  end

  def screen_must_have_film_format
    unless screen.formats.include?(detailed_film.format)
      errors.add(:screen, 'must have proper format for film')
    end
  end
end
