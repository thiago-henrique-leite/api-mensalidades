RSpec.describe EnrollmentSerializer do
  describe '#as_json' do
    let(:enrollment) { create(:enrollment) }
    let(:bills) { enrollment.bills.map { |bill| BillSerializer.new(bill).attributes } }

    subject { described_class.new(enrollment).as_json }

    it do
      is_expected.to eq({
        id: enrollment.id,
        amount: enrollment.amount,
        due_day: enrollment.due_day,
        installments: enrollment.installments,
        student_id: enrollment.student_id,
        bills: bills
      })
    end
  end
end
