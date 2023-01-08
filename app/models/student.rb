class Student < ApplicationRecord
  has_many :enrollments

  validates :birthdate, presence: true
  validates :cpf, cpf: true
  validates :name, presence: true
  validates :payment_method, presence: true

  enum payment_method: {
    boleto: 'boleto',
    credit_card: 'credit_card',
    pix: 'pix'
  }
end
