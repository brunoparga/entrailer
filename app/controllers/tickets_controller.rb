class TicketsController < ApplicationController
  def index
    @tickets = policy_scope(Ticket)
  end

  def show
    @ticket = current_user.tickets.where(status: 'paid').find(params[:id])
    authorize @ticket
  end

  def create
    @screening = Screening.find(params[:screening_id])
    @ticket = @screening.tickets.build(
      price_centavos: session[:ticket_price],
      purchase_time: Time.now,
      status: 'pending',
      user: current_user
    )
    authorize @ticket
    @ticket.save!
    redirect_to new_ticket_payment_path(@ticket)
  end

  private

  def params_ticket
    params.require(:ticket).permit(:screening_id, :user_id)
  end
end
