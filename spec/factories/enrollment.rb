FactoryBot.define do
  factory :enrollment do
    student { create(:student) }
    amount { 1000 }
    installments { 3 }
    due_day { 31 }
  end
end
