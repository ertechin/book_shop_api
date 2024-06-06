class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  devise :database_authenticatable, :registerable,
          :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :baskets

  def basket
    baskets.order(created_at: :desc).first
  end

  def has_empty_basket?
    basket.data.empty?
  end
end
