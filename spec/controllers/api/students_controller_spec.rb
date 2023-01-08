RSpec.describe Api::StudentsController, type: :request do
  describe '.index' do
    let!(:student) { create(:student) }
    let(:expected_response) { [StudentSerializer.new(student).as_json] }

    subject { get '/api/students' }

    it do
      expect { subject }.to_not raise_error

      expect(response).to be_ok
      expect(response.body).to eq(expected_response.to_json)
    end
  end

  describe '.show' do
    let(:student) { create(:student) }
    let(:expected_response) { StudentSerializer.new(student).as_json }

    subject { get "/api/students/#{student.id}" }

    it do
      expect { subject }.to_not raise_error

      expect(response).to be_ok
      expect(response.body).to eq(expected_response.to_json)
    end

    context 'when student with informed id not exists' do
      let(:expected_response) { { error: 'Record Not Found' } }

      subject { get '/api/students/111' }

      it do
        expect { subject }.to_not raise_error

        expect(response).to be_not_found
        expect(response.body).to eq(expected_response.to_json)
      end
    end
  end

  describe '.create' do
    let(:student) { Student.last }
    let(:expected_response) { StudentSerializer.new(student).as_json }
    let(:params) { { cpf: '174.790.380-97', birthdate: '28/02/2023', name: 'Frank', payment_method: 'boleto' } }

    subject { post '/api/students', params: params }

    it do
      expect { subject }.to_not raise_error

      expect(response).to be_created
      expect(response.body).to eq(expected_response.to_json)
    end

    context 'when params to create are invalid' do
      let(:expected_response) { { error: { cpf: ['is invalid'] } } }

      before { params.merge!(cpf: 123) }

      it do
        expect { subject }.to_not raise_error

        expect(response).to be_bad_request
        expect(response.body).to eq(expected_response.to_json)
      end
    end
  end

  describe '.update' do
    let(:student) { create(:student) }
    let(:expected_response) { StudentSerializer.new(student.reload).as_json }
    let(:params) { { name: 'LéoMessi' } }

    subject { put "/api/students/#{student.id}", params: params }

    it do
      expect { subject }.to_not raise_error

      expect(response).to be_ok
      expect(response.body).to eq(expected_response.to_json)
      expect(student.reload.name).to eq('LéoMessi')
    end
  end

  describe '.destroy' do
    let(:student) { create(:student) }

    subject { delete "/api/students/#{student.id}" }

    it do
      expect { subject }.to change(Student, :count).by(0)

      expect(response).to be_no_content
      expect(response.body).to be_blank
    end
  end
end
