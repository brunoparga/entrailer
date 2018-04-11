class DetailedFilmsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def index
    @detailed_films = policy_scope(DetailedFilm)
    authorize @detailed_films
  end

  def show
    @detailed_film = DetailedFilm.find(params[:id])
    authorize @detailed_film
  end

  def new
    @film_title = FilmTitle.find(params[:film_title_id])
    @detailed_film = @film_title.detailed_films.build
    authorize @detailed_film
    authorize @film_title
  end

  def create
    @film_title = FilmTitle.find(params[:film_title_id])
    @detailed_film = @film_title.detailed_films.build(params_detailed_film)
    authorize @detailed_film
    if @detailed_film.save
      redirect_to detailed_films_path
    else
      render :new
    end
  end

  def edit

  end

  def update
  end

  private

  def set_detailed_film
    @detailed_film = detailed_film.find(params[:id])
    authorize @detailed_film
  end

  def params_detailed_film
    params.require(:detailed_film).permit(:film_title_id, :speech, :format_id)
  end
end
