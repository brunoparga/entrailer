class OwnersController < ApplicationController
  def new
    @owner = current_user
    authorize @owner
  end

  def create
  end

  def show
  end
end
