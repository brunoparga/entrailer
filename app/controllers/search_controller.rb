class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def old_index

    if Screen.search_by_name("#{params[:query]}") != []
      @screens = Screen.search_by_name("#{params[:query]}")
    else
      @screens = policy_scope(Screen)
    end

    if FilmTitle.search_by_title("#{params[:query]}") != []
      @film_titles = policy_scope(FilmTitle.search_by_title("#{params[:query]}"))
    else
      @film_titles = policy_scope(FilmTitle)
    end


    if Screening.search_by_session_time("#{params[:query]}") != []
      @screenings = policy_scope(Screening.search_by_session_time("#{params[:query]}"))
    end
    set_markers(@screens)
  end

  def index
    # @screenings is an array of *screenings*, iterated on in the view.
    @screenings = []

    # Add all screenings in all screens that match the query
    Screen.search_by_name("#{params[:query]}").each do |screen|
      Screening.where(screen: screen).each do |screening|
        @screenings << screening
      end
    end

    # Add all screenings whose title matches the query
    FilmTitle.search_by_title("#{params[:query]}").each do |film_title|
      DetailedFilm.where(film_title: film_title).each do |detailed_film|
        Screening.where(detailed_film: detailed_film).each  do |screening|
          @screenings << screening
        end
      end
    end

    # Add all screenings whose time matches the query
    Screening.search_by_session_time("#{params[:query]}").each do |screening|
      @screenings << screening
    end

    @screens = @screenings.map { |screening| screening.screen }
    set_markers(@screens)
    authorize @screenings
  end

  private

  def set_markers(screens)
      @markers = screens.map do |screen|
        { lat: screen.latitude, lng: screen.longitude }
    end
  end
end
