# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy

  validates :cpf, cpf: true
  validates :birthdate, presence: true
  validates :name, presence: true
  validates :payment_method, presence: true

  enum payment_method: {
    boleto: 'boleto',
    credit_card: 'credit_card',
    pix: 'pix'
  }
end
