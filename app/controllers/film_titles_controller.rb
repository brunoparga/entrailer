class FilmTitlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @film_titles = policy_scope(FilmTitle)
    authorize @film_titles
  end

  def show
    @film_title = FilmTitle.find(params[:id])
    authorize @film_title
  end

  def new
    @film_title = FilmTitle.new
    authorize @film_title
  end

  def create
    @film_title = FilmTitle.new(film_title_params)
    @film_title.user = current_user
    authorize @film_title
    if @film.save
      redirect_to film_title_path(@film_title)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end
end
