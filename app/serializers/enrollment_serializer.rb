class EnrollmentSerializer < ActiveModel::Serializer
  attributes :id,
             :amount,
             :due_day,
             :installments,
             :student_id

  has_many :bills, serializer: BillSerializer
end
