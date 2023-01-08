RSpec.describe Bill do
  describe '.create' do
    let(:enrollment) { create(:enrollment) }
    let(:params) { { amount: 150, due_date: '28/02/2023', enrollment_id: enrollment.id } }

    subject { create(:bill, params) }

    before do
      allow(BillsCreator).to receive(:perform)
    end

    context 'when params are valid' do
      it do
        expect { subject }.to change(Bill, :count).by(1)

        expect(Bill.last).to have_attributes({
          amount: 150,
          due_date: Date.parse('28/02/2023'),
          enrollment_id: enrollment.id,
          status: 'open'
        })
      end
    end

    context 'when enrollment_id is invalid' do
      let(:error) { [ActiveRecord::RecordInvalid, 'Validation failed: Enrollment must exist'] }

      before { params.merge!(enrollment_id: -1) }

      it { expect { subject }.to raise_error(*error) }
    end

    context 'when amount is invalid' do
      let(:error) { [ActiveRecord::RecordInvalid, 'Validation failed: Amount must be greater than 0'] }

      before { params.merge!(amount: 0) }

      it { expect { subject }.to raise_error(*error) }
    end

    context 'when due_date is invalid' do
      let(:error) { [ActiveRecord::RecordInvalid, "Validation failed: Due date can't be blank"] }

      before { params.merge!(due_date: nil) }

      it { expect { subject }.to raise_error(*error) }
    end

    context 'when status is invalid' do
      let(:error) { [ArgumentError, "'invalid' is not a valid status"] }

      before { params.merge!(status: :invalid) }

      it { expect { subject }.to raise_error(*error) }
    end
  end

  describe '.statuses' do
    let(:statuses) { { 'open' => 'open', 'pending' => 'pending', 'paid' => 'paid' } }

    subject { described_class.statuses }

    it do
      expect(subject).to eq(statuses)
    end
  end
end
