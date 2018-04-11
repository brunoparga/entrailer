class ScreeningsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]

  def index
    @screenings = Screening.all
  end

  def show
    @screening = Screening.find(params[:id])
  end

  def new
    @screening = Screening.new
    @films = DetailedFilm.all.map { |film| film.prepare_for_display }
    # @screens = current_user.screens
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
                                      :screen_id, :session_time, :closing_time)
  end
end
