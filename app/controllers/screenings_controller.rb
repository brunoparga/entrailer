class ScreeningsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]

  def index
    @screenings = policy_scope(Screening)
    authorize @screenings
  end

  def show
    @screening = Screening.find(params[:id])
    authorize @screening
    @new_ticket = @screening.sold_tickets.build
    @sold_tickets = @screening.sold_tickets.count
    session[:ticket_price] = @screening.calculate_price(Time.now)
  end

  def new
    @screening = Screening.new
    authorize @screening
    @films = DetailedFilm.all.map { |film| film.prepare_for_display }
    # TODO: @screens = current_user.screens
    @screens = Screen.all.map { |screen| screen.prepare_for_display }
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
                                      :max_price_centavos, :min_price_centavos)
  end
end
