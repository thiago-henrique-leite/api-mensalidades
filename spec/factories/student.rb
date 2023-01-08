FactoryBot.define do
  factory :student do
    name { 'Ada Lovelace' }
    cpf { CPF.generate }
    birthdate { 21.years.ago }
    payment_method { :credit_card }
  end
end
