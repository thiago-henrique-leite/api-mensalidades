# frozen_string_literal: true

class Bill < ApplicationRecord
  belongs_to :enrollment

  validates :amount, numericality: { greater_than: 0 }
  validates :due_date, presence: true
  validates :status, presence: true

  enum status: {
    open: 'open',
    pending: 'pending',
    paid: 'paid'
  }
end
