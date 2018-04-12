class FilmTitlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @film_titles = policy_scope(FilmTitle.search_by_title("#{params[:query]}"))
    @film_titles = policy_scope(FilmTitle) if @film_titles.count.zero?
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
    authorize @film_title
    if @film_title.save
      FilmTitleMailer.analysis.deliver_now
      redirect_to film_title_path(@film_title)
    else
      render :new
    end
  end

  def edit
    set_film_title
    authorize @film_title
  end

  def update
  end

  private

  def set_film_title
    @film_title = FilmTitle.find(params[:id])
    authorize @film_title
  end

  def film_title_params
    params.require(:film_title).permit(:title, :imdb_id)
  end
end
