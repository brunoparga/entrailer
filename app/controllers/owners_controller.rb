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

  def show; end

  private

  def set_owner
    @owner = current_user
    authorize @owner
  end

  def owner_params
    params.require(:user).permit(:cnpj, :address)
  end
end
