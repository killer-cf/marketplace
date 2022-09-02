class Card < ApplicationRecord
  validates :code, :name, :number, :cpf, presence: true
  validates :number, length: { is: 16 }
  validates :code, length: { is: 3 }
  validates :cpf, length: { is: 11 }
  belongs_to :client
end
