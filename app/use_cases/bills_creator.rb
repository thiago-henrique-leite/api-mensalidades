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

  def effective_due_date(date)
    Date.civil(date.year, date.month, due_day)
  rescue Date::Error
    Date.civil(date.year, date.month, -1)
  end

  def create_bills
    first_date = today.day < due_day ? today : today.next_month

    installments.times do |index|
      date = first_date.next_month(index)

      Bill.create!(
        amount: amounts[index],
        due_date: effective_due_date(date),
        enrollment: enrollment
      )
    end
  end

  def today
    @today ||= Time.zone.today
  end
end
