class Card < ApplicationRecord
  validates :code, presence: true
  belongs_to :client
end
