# frozen_string_literal: true

class BillSerializer < ActiveModel::Serializer
  attributes :id, :due_date, :status, :amount
end
