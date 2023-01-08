RSpec.describe BillSerializer do
  describe '#as_json' do
    let(:bill) { create(:bill) }

    subject { described_class.new(bill).as_json }

    it do
      is_expected.to eq({
        id: bill.id,
        amount: bill.amount,
        due_date: bill.due_date,
        status: bill.status,
        enrollment_id: bill.enrollment_id
      })
    end
  end
end
