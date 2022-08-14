# frozen_string_literal: true

class BillSerializer < ActiveModel::Serializer
  attributes :id, :due_date, :status, :amount, :student_name

  def student_name
    @object.enrollment.student.name
  end
end
