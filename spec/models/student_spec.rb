RSpec.describe Student do
  describe '.create' do
    let(:params) { { cpf: '174.790.380-97', birthdate: '28/02/2023', name: 'Frank', payment_method: 'boleto' } }

    subject { create(:student, params) }

    context 'when params are valid' do
      it do
        expect { subject }.to change(Student, :count).by(1)

        expect(Student.last).to have_attributes({
          cpf: '17479038097',
          birthdate: Date.parse('28/02/2023'),
          name: 'Frank',
          payment_method: 'boleto'
        })
      end
    end

    context 'when cpf is invalid' do
      let(:error) { [ActiveRecord::RecordInvalid, 'Validation failed: Cpf is invalid'] }

      before { params.merge!(cpf: 'invalid') }

      it { expect { subject }.to raise_error(*error) }
    end

    context 'when birthdate is invalid' do
      let(:error) { [ActiveRecord::RecordInvalid, "Validation failed: Birthdate can't be blank"] }

      before { params.merge!(birthdate: nil) }

      it { expect { subject }.to raise_error(*error) }
    end

    context 'when name is invalid' do
      let(:error) { [ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank"] }

      before { params.merge!(name: nil) }

      it { expect { subject }.to raise_error(*error) }
    end

    context 'when payment_method is invalid' do
      let(:error) { [ArgumentError, "'invalid' is not a valid payment_method"] }

      before { params.merge!(payment_method: :invalid) }

      it { expect { subject }.to raise_error(*error) }
    end
  end

  describe '.payment_methods' do
    let(:payment_methods) { { 'boleto' => 'boleto', 'credit_card' => 'credit_card', 'pix' => 'pix' } }

    subject { described_class.payment_methods }

    it do
      expect(subject).to eq(payment_methods)
    end
  end
end
