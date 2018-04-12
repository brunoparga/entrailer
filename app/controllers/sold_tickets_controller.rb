class SoldTicketsController < ApplicationController
  def index
    @sold_tickets = policy_scope(SoldTicket)
  end

  def show
    @ticket = SoldTicket.find(params[:id])
    authorize @ticket
  end

  def create
    @screening = Screening.find(params[:screening_id])
    @sold_ticket = @screening.sold_tickets.build(
      price_centavos: session[:ticket_price],
      purchase_time: @screening.session_time - 300,
      user: current_user
    )
    authorize @sold_ticket
    if @sold_ticket.save
      session[:ticket_price] = nil
      redirect_to sold_ticket_path(@current_user)
    else
      redirect_to screening_path(@screening)

    end
  end

  private

  def params_sold_ticket
    params.require(:sold_ticket).permit(:screening_id, :user_id)
  end
end
