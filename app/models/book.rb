class Book < ApplicationRecord
  validates :title, :author, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  scope :recently_created, -> { order(created_at: :desc) }
end
