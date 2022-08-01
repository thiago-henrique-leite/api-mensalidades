# frozen_string_literal: true

class Enrollment < ApplicationRecord
  belongs_to :student
  has_many :bills, dependent: :destroy

  validates :amount, numericality: { greater_than: 0, message: I18n.t('errors.enrollments.amount') }
  validates :due_day, numericality: { greater_than: 0, less_than: 32, message: I18n.t('errors.enrollments.due_day') }
  validates :installments, numericality: { greater_than: 1, message: I18n.t('errors.enrollments.installments') }

  after_create :create_enrollment_bills

  private

  def create_enrollment_bills
    EnrollmentBillsCreation.perform(self)
  end
end
