class PaymentsController < ApplicationController
  before_action :set_sold_ticket

  def new
  end

  def create
    # ...
  end

private

  def set_sold_ticket
    @sold_ticket = current_user.sold_tickets.where(state: 'pending').find(params[:sold_ticket_id])
  end
end
