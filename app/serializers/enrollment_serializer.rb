# frozen_string_literal: true

class EnrollmentSerializer < ActiveModel::Serializer
  attributes :id, :student_id, :amount, :installments, :due_day, :bills

  def bills
    object.bills.map { |bill| BillSerializer.new(bill).as_json }
  end
end
