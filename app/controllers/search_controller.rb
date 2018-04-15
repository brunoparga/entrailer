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
    else
      @screens = policy_scope(Screen) if @screens.count.nil?
    end

    if Screening.search_by_session_time("#{params[:query]}") != nil
      @screenings = policy_scope(Screening.search_by_session_time("#{params[:query]}"))
     # @film_titles = policy_scope(FilmTitle)
    else
      @screenings = policy_scope(Screening) if @screenings.count.nil?
    end

  end

end
