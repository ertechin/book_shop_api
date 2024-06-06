class Payment < ApplicationRecord
  belongs_to :user

  enum status: %i[success failed]

  validates :user, :status, presence: true

  class << self
    def process(user)
      payment_processor = Iyzi.new(user.basket.total_price)
      payment_data = payment_processor.process
      if payment_data[:status] == 'success'
        user.basket.clear_basket
        Payment.create_payment_data(user, payment_data)
        true
      else
        Payment.create_payment_data(user, payment_data)
        false
      end
    end

    def create_payment_data(user, payment_data)
      Payment.create!(user:, payment_data:, status: payment_data[:status].to_sym)
    end
  end
end
