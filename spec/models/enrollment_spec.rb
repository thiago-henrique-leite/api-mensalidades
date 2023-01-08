RSpec.describe Enrollment do
  describe '.create' do
    let(:student) { create(:student) }
    let(:params) { { amount: 1000, due_day: 31, installments: 4, student_id: student.id } }

    subject { create(:enrollment, params) }

    context 'when params are valid' do
      it do
        expect(BillsCreator).to receive(:perform).once.and_call_original

        expect { subject }.to change(Enrollment, :count).by(1)

        expect(Enrollment.last.bills.count).to eq(params[:installments])
        expect(Enrollment.last).to have_attributes({
          amount: 1000,
          due_day: 31,
          installments: 4,
          student_id: student.id
        })
      end
    end

    context 'when amount is invalid' do
      let(:error) { [ActiveRecord::RecordInvalid, 'Validation failed: Amount must be greater than 0'] }

      before { params.merge!(amount: 0) }

      it { expect { subject }.to raise_error(*error) }
    end

    context 'when due_day is invalid' do
      let(:error) { [ActiveRecord::RecordInvalid, 'Validation failed: Due day is not included in the list'] }

      context 'when due_day is less than 1' do
        before { params.merge!(due_day: 0) }

        it { expect { subject }.to raise_error(*error) }
      end

      context 'when due_day is greather than 31' do
        before { params.merge!(due_day: 32) }

        it { expect { subject }.to raise_error(*error) }
      end
    end

    context 'when installments is invalid' do
      let(:error) { [ActiveRecord::RecordInvalid, 'Validation failed: Installments must be greater than 1'] }

      before { params.merge!(installments: 0) }

      it { expect { subject }.to raise_error(*error) }
    end

    context 'when student_id is invalid' do
      let(:error) { [ActiveRecord::RecordInvalid, 'Validation failed: Student must exist'] }

      before { params.merge!(student_id: -1) }

      it { expect { subject }.to raise_error(*error) }
    end
  end
end
