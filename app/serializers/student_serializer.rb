# frozen_string_literal: true

class StudentSerializer < ActiveModel::Serializer
  attributes :id, :name, :cpf, :birthdate, :payment_method
end
