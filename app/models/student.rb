# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy

  PAYMENT_METHODS = %w[boleto credit_card pix].freeze

  validates :cpf, cpf: true
  validates :birthdate, presence: { message: I18n.t('errors.students.birthdate') }
  validates :name, presence: { message: I18n.t('errors.students.name') }
  validates :payment_method, inclusion: { in: PAYMENT_METHODS, message: I18n.t('errors.students.payment_method') }
end
