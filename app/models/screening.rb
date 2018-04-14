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

  include PgSearch
  pg_search_scope :search_by_session_time,
    against: [ :session_time ],
    using: {
      tsearch: { prefix: true }
    }

  def calculate_price(purchase_time)
    # purchase_time is the time the controller calls this method
    # returns a price in centavos as an integer

    # TODO: use closing time, include it in the price decay period.
    # TODO: use demand, measured by remaining tickets.
    # TODO: change the increase and decay from exponential to logistic/tanh?
    # TODO: return a Money object?

    price_params =
      { decay_end: 0,             # Prices finish decaying at session time
        decay_start: 900,         # Prices start decaying 15 minutes before session
        increase_start: 604_800,  # Prices start increasing a week before session
        max_start: 10_800,        # Prices peak three hours before session
        early_bird_factor: 1 }    # A week before, prices are this times the minimum

    # How long between now and session time?
    interval = session_time - purchase_time
    Money
      .new(price_calculator(interval, price_params), 'BRL')
      .format(symbol_before_without_space: false)
  end

  private

  def price_calculator(interval, price_params)
    # interval: the duration between reference time and session start time
    # price_params are set at #calculate_price
    # returns the correct price in centavos
    return min_price_cents if interval.negative?

    if interval <= price_params[:decay_start]
      return decay(interval,
                   max_price_cents,
                   min_price_cents,
                   price_params[:decay_start],
                   price_params[:decay_end])
    end

    return max_price_cents if interval <= price_params[:max_start]

    early_bird = min_price_cents * price_params[:early_bird_factor]
    if interval <= price_params[:increase_start]
      return increase(interval,
                      max_price_cents,
                      early_bird,
                      price_params[:increase_start],
                      price_params[:max_start])
    end

    return early_bird
  end

  def decay(interval, max_price, min_price, max_price_time, min_price_time)
    price_range = max_price - min_price
    duration = max_price_time - min_price_time

    # Add 1 to price_range because it is subtracted later
    exp_constant = Math.log(price_range + 1) / duration

    # Subtract 1 because this is added to e^0=1
    min = min_price_cents - 1

    (min + Math.exp(interval * exp_constant)).round
  end

  def increase(interval, max_price, min_price, max_price_time, min_price_time)
    duration = (max_price_time - min_price_time).abs
    proportion = 1 - ((interval - 10_800) / duration)
    price_range = max_price - min_price
    min_price + (proportion * price_range).round
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
