class ScreeningsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]

  def index
    @screenings = policy_scope(Screening)
    authorize @screenings
  end

  def show
    @screening = Screening.find(params[:id])
    authorize @screening
    @ticket = @screening.tickets.build
    @available_tickets = @screening.initial_tickets - @screening.tickets.count
    @detailed_film = DetailedFilm.find(id = @screening.detailed_film_id)
    @film_title = FilmTitle.find(id = @detailed_film.film_title_id)
    authorize @film_title
    session["screening_#{@screening.id}_price".to_sym] ||= @screening.calculate_price(Time.now, @available_tickets)
  end

  def new
    @screening = Screening.new
    authorize @screening
    @films = DetailedFilm.all.map { |film| film.prepare_for_display }
    @screens = current_user.screens.map { |screen| screen.prepare_for_display }
  end

  def create
    @screening = Screening.new(params_screening)
    authorize @screening
    if @screening.save
      redirect_to screening_path(@screening)
    else
      render :new
    end
  end

  def destroy
  end

  private

  def params_screening
    params.require(:screening).permit(:initial_tickets, :detailed_film_id,
                                      :screen_id, :session_time, :closing_time,
                                      :max_price_cents, :min_price_cents)
  end
end
