# frozen_string_literal: true

class StudentSerializer < ActiveModel::Serializer
  attributes :id,
             :birthdate,
             :cpf,
             :name,
             :payment_method

  has_many :enrollments, serializer: EnrollmentSerializer
end
