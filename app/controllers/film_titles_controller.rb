class FilmTitlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @film_titles
    authorize @film_titles
  end

  def new
    @film_title = FilmTitle.new
    authorize @film_title
  end

  def create
    @film_title = FilmTitle.new(film_title_params)
    authorize @film_title
    if @film_title.save
      # TODO: FilmTitleMailer.analysis.deliver_now
      redirect_to film_titles_path
    else
      render :new
    end
  end

  private

  def set_film_title
    @film_title = FilmTitle.find(params[:id])
    authorize @film_title
  end

  def film_title_params
    params.require(:film_title).permit(:title, :imdb_id, :img_url, :banner_url)
  end
end
