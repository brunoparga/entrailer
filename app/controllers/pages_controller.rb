class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @screenings = Screening.all
    authorize @screenings
  end
end
