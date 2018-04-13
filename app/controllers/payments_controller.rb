class PaymentsController < ApplicationController
  before_action :set_sold_ticket

  def new
    @sold_ticket = SoldTicket.find(params[:sold_ticket_id])
  end

  def create
  customer = Stripe::Customer.create(
    source: params[:stripeToken],
    email:  params[:stripeEmail]
  )

  charge = Stripe::Charge.create(
    customer:     customer.id,   # You should store this customer id and re-use it.
    amount:       @sold_ticket.price_centavos,
    description:  "Ticket for #{@sold_ticket.screening.detailed_film.film_title.title} for order #{@sold_ticket.id}",
    currency:     @sold_ticket.price.currency
  )

  @sold_ticket.update(payment: charge.to_json, status: 'paid')
  redirect_to sold_ticket_path(@sold_ticket)
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_sold_ticket_payment_path(@sold_ticket)
  end

  private

  def set_sold_ticket
    @sold_ticket = current_user.sold_tickets.where(status: 'pending').find(params[:sold_ticket_id])
    authorize @sold_ticket
  end
end
