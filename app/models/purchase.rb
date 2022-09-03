class Purchase < ApplicationRecord
  enum status: { pending: 0, approved: 5, rejected: 9 }

  belongs_to :client
  has_many :product_items, dependent: :nullify

  before_validation :generate_order

  private

  def generate_order
    self.order = SecureRandom.alphanumeric(10).upcase
  end
end
