class OwnersController < ApplicationController
  def new
    @owner = current_user
    authorize @owner
  end

  def update
    @owner = current_user
    @owner.role = 'theater_owner'
    if @owner.save
      redirect_to owner_path(@owner)
    else
      render :new
    end
  end

  def show
  end
end
