class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @screenings = Screening.pick_four
    @screenings.each { |scg| authorize scg }
  end
end
