class Book < ApplicationRecord
  validates :title, :author, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  scope :recently_created, -> { order(created_at: :desc) }

  scope :books_in_basket, ->(basket) { where(id: basket.item_ids) }
end
