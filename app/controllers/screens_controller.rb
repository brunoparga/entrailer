class ScreensController < ApplicationController
  def index
    @screens = policy_scope(Screen)
    authorize @screens
  end

  def show
    @screen = Screen.find(params[:screen_id])
    authorize @screen
  end
end
