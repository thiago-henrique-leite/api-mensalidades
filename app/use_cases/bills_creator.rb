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

  def create_bills
    amounts.each_with_index do |amount, index|
      date = first_due_date.next_month(index)

      Bill.create!(amount: amount, due_date: effective_due_date(date), enrollment: enrollment)
    end
  end

  def effective_due_date(date)
    date.change(day: due_day)
  rescue Date::Error
    date.end_of_month
  end

  def first_due_date
    @first_due_date ||= today.day < due_day ? today : today.next_month
  end

  def today
    @today ||= Time.zone.today
  end
end
