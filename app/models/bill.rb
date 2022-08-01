# frozen_string_literal: true

class Bill < ApplicationRecord
  belongs_to :enrollment

  validates :amount, numericality: { greater_than: 0, message: I18n.t('errors.bills.amount') }
  validates :due_date, presence: { message: I18n.t('errors.bills.due_date') }
  validates :status, inclusion: { in: %w[open pending paid], message: I18n.t('errors.bills.status') }
end
