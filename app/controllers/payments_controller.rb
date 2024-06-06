class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    if Payment.process(current_user)
      render json: { message: 'Payment successful' }, status: :ok
    else
      render json: { message: 'Payment failed' }, status: :unprocessable_entity
    end
  end
end
