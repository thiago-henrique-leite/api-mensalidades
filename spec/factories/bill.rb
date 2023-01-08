FactoryBot.define do
  factory :bill do
    enrollment { create(:enrollment) }
    amount { 199.99 }
    due_date { 10.days.since }
    status { 'open' }
  end
end
