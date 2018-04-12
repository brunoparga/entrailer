class ScreensController < ApplicationController
  def index
    @screens = policy_scope(Screen)
    authorize @screens
  end

  def show
    @screen = Screen.find(params[:id])
    authorize @screen
  end
  def new
    @screen = Screen.new
    authorize @screen
  end

  def create
    @screen = Screen.new(params_screen)
    @screen.user = current_user
    authorize @screen
    if @screen.save
      redirect_to screen_path(@screen)
    else
      render :new
    end
  end

  def edit
    set_screen
  end

  def update
    set_screen
    @screen.update(params_screen)
    #binding.pry
    if @screen.save
      redirect_to screen_path(@screen)
    else
      render :new
    end
  end


private
def set_screen
  @screen = Screen.find(params[:id])
  authorize @screen
end

def params_screen
  params.require(:screen).permit(:capacity, :address, :name)
end

end
