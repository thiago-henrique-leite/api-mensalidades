# frozen_string_literal: true

class EnrollmentBillsCreation
  include UseCase

  attr_reader :enrollment

  def initialize(enrollment)
    @enrollment = enrollment
  end

  def perform
    create_enrollment_bills
  end

  private

  def today
    @today ||= Time.zone.today
  end

  def create_enrollment_bills
    first_due_date = today.day < enrollment.due_day ? today : today.next_month

    enrollment.installments.times do |index|
      date = first_due_date.next_month(index)

      Bill.create!(amount: bill_amount, due_date: build_due_date(date.year, date.month), enrollment_id: enrollment.id)
    end
  end

  def build_due_date(year, month)
    Date.civil(year, month, enrollment.due_day)
  rescue Date::Error
    Date.civil(year, month, -1)
  end

  def bill_amount
    @bill_amount ||= enrollment.amount / enrollment.installments
  end
end
