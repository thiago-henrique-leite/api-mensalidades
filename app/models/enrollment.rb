class Enrollment < ApplicationRecord
  belongs_to :student
  has_many :bills, dependent: :destroy

  validates :amount, numericality: { greater_than: 0 }
  validates :due_day, numericality: { greater_than_or_equal: 1, less_than_or_equal: 31 }
  validates :installments, numericality: { greater_than: 1 }

  after_create :create_bills

  private

  def create_bills
    BillsCreator.perform(self)
  end
end
