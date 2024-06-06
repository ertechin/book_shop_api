class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_total_price, only: :create

  def create
    if Payment.process(current_user)
      render json: { message: 'Payment successful' }, status: :ok
    else
      render json: { message: 'Payment failed' }, status: :unprocessable_entity
    end
  end

  private

  def check_total_price
    return if current_user.basket.total_price.positive?

    render json: { message: 'Basket is empty' }, status: :unprocessable_entity
  end
end
