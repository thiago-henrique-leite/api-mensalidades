RSpec.describe BillsCreator do
  describe '.perform' do
    before { allow_any_instance_of(Enrollment).to receive(:create_bills) }

    let(:installments) { 3 }
    let(:enrollment) { create(:enrollment, installments: installments) }

    subject { described_class.perform(enrollment) }

    describe 'happy path' do
      let(:bills) { enrollment.bills.map { |bill| bill.attributes.with_indifferent_access } }

      it 'creates enrollment bills correctly' do
        expect { subject }.to change(Bill, :count).by(installments)

        expect(bills[0]).to include(enrollment_id: enrollment.id, amount: 0.33334e3, due_date: Date.parse('31/01/2023'))
        expect(bills[1]).to include(enrollment_id: enrollment.id, amount: 0.33333e3, due_date: Date.parse('28/02/2023'))
        expect(bills[2]).to include(enrollment_id: enrollment.id, amount: 0.33333e3, due_date: Date.parse('31/03/2023'))
      end

      it 'validations' do
        expect { subject }.to_not raise_error

        expect(enrollment.amount).to eq(enrollment.bills.sum(:amount))
        expect(enrollment.installments).to eq(enrollment.bills.count)
      end
    end
  end
end
