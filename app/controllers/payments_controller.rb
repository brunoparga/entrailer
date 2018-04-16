class PaymentsController < ApplicationController
  before_action :set_ticket

  def new
    @ticket = Ticket.find(params[:ticket_id])
  end

  def create
  customer = Stripe::Customer.create(
    source: params[:stripeToken],
    email:  params[:stripeEmail]
  )

  charge = Stripe::Charge.create(
    customer: customer.id,  # TODO: You should store this customer id and re-use it.
    amount: @ticket.price_cents,
    description: "Ticket for #{@ticket.screening.detailed_film.film_title.title} for order #{@ticket.id}",
    currency: @ticket.price.currency
  )

  @ticket.update(payment: charge.to_json, status: 'paid')
  redirect_to ticket_path(@ticket)
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_ticket_payment_path(@ticket)
  end

  private

  def set_ticket
    @ticket = current_user
              .tickets
              .where(status: 'pending')
              .find(params[:ticket_id])
    authorize @ticket
  end
end
