# frozen_string_literal: true

class BillSerializer < ActiveModel::Serializer
  attributes :id,
             :amount,
             :due_date,
             :status
end
