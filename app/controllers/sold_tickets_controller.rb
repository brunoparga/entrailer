class SoldTicketsController < ApplicationController
  def index
    @sold_tickets = policy_scope(SoldTicket)
  end

  def show
    @sold_ticket = current_user
                   .sold_tickets
                   .where(status: 'paid')
                   .find(params[:id])
    authorize @sold_ticket
  end

  def create
    @screening = Screening.find(params[:screening_id])
    @sold_ticket = @screening.sold_tickets.build(
      price_centavos: session[:ticket_price],
      purchase_time: @screening.session_time - 300,
      status: 'pending',
      user: current_user
    )
    authorize @sold_ticket
    @sold_ticket.save!
    redirect_to new_sold_ticket_payment_path(@sold_ticket)
  end

  private

  def params_sold_ticket
    params.require(:sold_ticket).permit(:screening_id, :user_id)
  end
end
