class FilmTitlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
  end

  def show
  end

  def new
    @film = FilmTitle.new
  end

  def create
    @film = FilmTitle.new(film_params)
    @film.user = current_user
    if @film.save
      redirect_to film_path(@film)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end
end
