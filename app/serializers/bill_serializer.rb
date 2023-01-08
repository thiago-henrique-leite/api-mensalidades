class BillSerializer < ActiveModel::Serializer
  attributes :id,
             :amount,
             :due_date,
             :enrollment_id,
             :status
end
