# frozen_string_literal: true

class EnrollmentSerializer < ActiveModel::Serializer
  attributes :id, :student_id, :student_name, :amount, :installments, :due_day, :bills

  def bills
    object.bills.map { |bill| BillSerializer.new(bill).as_json }
  end

  def student_name
    object.student.name
  end
end
