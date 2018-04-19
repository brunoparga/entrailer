class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @screenings = policy_scope(Screening.pick_four)
    authorize @screenings
  end
end
