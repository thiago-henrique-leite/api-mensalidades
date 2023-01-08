RSpec.describe Api::BillsController, type: :request do
  before { allow(BillsCreator).to receive(:perform) }

  describe '.index' do
    let!(:bill) { create(:bill) }
    let(:expected_response) { [BillSerializer.new(bill).as_json] }

    subject { get '/api/bills' }

    it do
      expect { subject }.to_not raise_error

      expect(response).to be_ok
      expect(response.body).to eq(expected_response.to_json)
    end
  end

  describe '.show' do
    let(:bill) { create(:bill) }
    let(:expected_response) { BillSerializer.new(bill).as_json }

    subject { get "/api/bills/#{bill.id}" }

    it do
      expect { subject }.to_not raise_error

      expect(response).to be_ok
      expect(response.body).to eq(expected_response.to_json)
    end

    context 'when bill with informed id not exists' do
      let(:expected_response) { { error: 'Record Not Found' } }

      subject { get '/api/bills/111' }

      it do
        expect { subject }.to_not raise_error

        expect(response).to be_not_found
        expect(response.body).to eq(expected_response.to_json)
      end
    end
  end

  describe '.update' do
    let(:bill) { create(:bill) }
    let(:expected_response) { BillSerializer.new(bill.reload).as_json }
    let(:params) { { status: 'paid' } }

    subject { put "/api/bills/#{bill.id}", params: params }

    it do
      expect { subject }.to_not raise_error

      expect(response).to be_ok
      expect(response.body).to eq(expected_response.to_json)
      expect(bill.reload.status).to eq('paid')
    end
  end

  describe '.destroy' do
    let(:bill) { create(:bill) }

    subject { delete "/api/bills/#{bill.id}" }

    it do
      expect { subject }.to change(Bill, :count).by(0)

      expect(response).to be_no_content
      expect(response.body).to be_blank
    end
  end
end
