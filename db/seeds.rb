# frozen_string_literal: true

ActiveRecord::Base.transaction do
  10.times do
    Student.create!(
      name: FFaker::NameBR.name,
      cpf: CPF.generate,
      birthdate: Faker::Date.between(from: '1990-01-01', to: '2002-01-01'),
      payment_method: %w[boleto credit_card pix].sample
    )

    Enrollment.create!(
      student: Student.last,
      amount: Faker::Number.decimal(l_digits: 4, r_digits: 2),
      installments: Faker::Number.between(from: 1, to: 10),
      due_day: Faker::Number.between(from: 1, to: 31)
    )
  end
end
