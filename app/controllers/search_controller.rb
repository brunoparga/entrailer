class SearchController < ApplicationController
  def index
    if FilmTitle.search_by_title("#{params[:query]}") != []
      @film_titles = policy_scope(FilmTitle.search_by_title("#{params[:query]}"))
    else # FilmTitle.search_by_title("#{params[:query]}") == []
      @film_titles = policy_scope(FilmTitle)
    end

    if Screen.search_by_name("#{params[:query]}") != nil
      @screens = Screen.search_by_name("#{params[:query]}")
    #  @film_titles = policy_scope(FilmTitle)
    elsif @screens.count.nil?
      @screens = policy_scope(Screen)
    end

    if Screening.search_by_session_time("#{params[:query]}") != nil
      @screenings = policy_scope(Screening.search_by_session_time("#{params[:query]}"))
     # @film_titles = policy_scope(FilmTitle)
    elsif @screenings.count.nil?
      @screenings = policy_scope(Screening)
    end
  end
end
