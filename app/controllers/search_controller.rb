class SearchController < ApplicationController
  skip_before_action :authenticate_user!

  def index

    if Screen.search_by_name("#{params[:query]}") != []
      @screens = Screen.search_by_name("#{params[:query]}")
      set_markers(@screens)
    else
      @screens = policy_scope(Screen)
      set_markers(@screens)
    end

    if FilmTitle.search_by_title("#{params[:query]}") != []
      @film_titles = policy_scope(FilmTitle.search_by_title("#{params[:query]}"))
       set_markers(@screens)
    else
      @film_titles = policy_scope(FilmTitle)
      set_markers(@screens)
    end


    if Screening.search_by_session_time("#{params[:query]}") != []
      @screenings = policy_scope(Screening.search_by_session_time("#{params[:query]}"))
        set_markers(@screens)
    end
  end

  private

  def set_markers(screens)
      @markers = screens.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude#,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }
    end
  end
end
