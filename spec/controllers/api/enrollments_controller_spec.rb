RSpec.describe Api::EnrollmentsController, type: :request do
  describe '.index' do
    let!(:enrollment) { create(:enrollment) }
    let(:expected_response) { [EnrollmentSerializer.new(enrollment).as_json] }

    subject { get '/api/enrollments' }

    it do
      expect { subject }.to_not raise_error

      expect(response).to be_ok
      expect(response.body).to eq(expected_response.to_json)
    end
  end

  describe '.show' do
    let(:enrollment) { create(:enrollment) }
    let(:expected_response) { EnrollmentSerializer.new(enrollment).as_json }

    subject { get "/api/enrollments/#{enrollment.id}" }

    it do
      expect { subject }.to_not raise_error

      expect(response).to be_ok
      expect(response.body).to eq(expected_response.to_json)
    end

    context 'when enrollment with informed id not exists' do
      let(:expected_response) { { error: 'Record Not Found' } }

      subject { get '/api/enrollments/111' }

      it do
        expect { subject }.to_not raise_error

        expect(response).to be_not_found
        expect(response.body).to eq(expected_response.to_json)
      end
    end
  end

  describe '.create' do
    let(:student) { create(:student) }
    let(:enrollment) { Enrollment.last }
    let(:expected_response) { EnrollmentSerializer.new(enrollment).as_json }
    let(:params) { { amount: 1000, due_day: 31, installments: 4, student_id: student.id } }

    subject { post '/api/enrollments', params: params, headers: authorization_header }

    context 'when user is authenticated' do
      setup_basic_auth(Settings.auth.username, Settings.auth.password)

      it do
        expect { subject }.to_not raise_error

        expect(response).to be_created
        expect(response.body).to eq(expected_response.to_json)
      end

      context 'when params to create are invalid' do
        let(:expected_response) { { error: { student: ['must exist'] } } }

        before { params.merge!(student_id: 123) }

        it do
          expect { subject }.to_not raise_error

          expect(response).to be_bad_request
          expect(response.body).to eq(expected_response.to_json)
        end
      end
    end

    context 'when user is not authenticated' do
      let(:authorization_header) { {} }
      let(:expected_response) { "HTTP Basic: Access denied.\n" }

      it do
        expect { subject }.to_not raise_error

        expect(response).to be_unauthorized
        expect(response.body).to eq(expected_response)
      end
    end
  end

  describe '.update' do
    let(:enrollment) { create(:enrollment) }
    let(:expected_response) { EnrollmentSerializer.new(enrollment.reload).as_json }
    let(:params) { { amount: 5000 } }

    subject { put "/api/enrollments/#{enrollment.id}", params: params }

    it do
      expect { subject }.to_not raise_error

      expect(response).to be_ok
      expect(response.body).to eq(expected_response.to_json)
      expect(enrollment.reload.amount).to eq(5000)
    end
  end

  describe '.destroy' do
    let(:enrollment) { create(:enrollment) }

    subject { delete "/api/enrollments/#{enrollment.id}" }

    context 'when enrollment has bills' do
      it do
        expect { subject }.to raise_error(ActiveRecord::InvalidForeignKey)
      end
    end

    context 'when enrollment does not have bills' do
      before do
        enrollment.bills.each(&:destroy!)
      end

      it do
        expect { subject }.to change(Enrollment, :count).by(-1)

        expect(response).to be_no_content
        expect(response.body).to be_blank
      end
    end
  end
end
