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
    # Match the price with a regexp
    # Find match group 1
    # Remove the comma
    # Integrify it
    cents = session["screening_#{@screening.id}_price".to_sym].match(/(\d+,\d{0,2})/)[1].sub(',', '').to_i
    @ticket = @screening.tickets.build(
      price_cents: cents,
      purchase_time: Time.zone.now,
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
