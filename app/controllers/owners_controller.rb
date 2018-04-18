class OwnersController < ApplicationController
  before_action :set_owner

  def new; end

  def update
    @owner.role = 'theater_owner'
    if @owner.update(owner_params)
      redirect_to owner_path(@owner)
    else
      render :new
    end
  end

  def show
    @film_titles = policy_scope(FilmTitle)
    authorize @film_titles
    @screens = policy_scope(Screen.where(user: current_user))
    @screens.each { |screen| authorize screen }
    @past_screenings = current_user.screenings.past(Time.zone.now)
    @open_screenings = current_user.screenings.open(Time.zone.now)
  end

  private

  def set_owner
    @owner = current_user
    authorize @owner
  end

  def owner_params
    params.require(:user).permit(:cnpj, :address)
  end
end
