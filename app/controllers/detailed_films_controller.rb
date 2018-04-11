class DetailedFilmsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def index
    @detailed_films = DetailedFilm.all
    authorize @detailed_films
  end

  def show
    @detailed_film = DetailedFilm.find(params[:id])
    authorize @detailed_film
  end

  def new
    @detailed_film = DetailedFilm.new
  end

  def create

  end

  def edit
  end

  def update
  end
end
