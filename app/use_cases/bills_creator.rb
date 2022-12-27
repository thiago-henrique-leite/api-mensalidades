# frozen_string_literal: true

class BillsCreator
  include UseCase

  def initialize(enrollment)
    @enrollment = enrollment
    @amount = enrollment.amount
    @due_day = enrollment.due_day
    @installments = enrollment.installments
  end

  def perform
    create_bills
  end

  private

  attr_reader :amount, :due_day, :enrollment, :installments

  def amounts
    @amounts ||= Money.from_amount(amount).allocate(installments).map(&:to_f)
  end

  def due_dates
    @due_dates ||= DateUtils.allocate(due_day, installments)
  end

  def create_bills
    installments.times do |index|
      Bill.create!(
        amount: amounts[index],
        due_date: due_dates[index],
        enrollment: enrollment
      )
    end
  end
end
