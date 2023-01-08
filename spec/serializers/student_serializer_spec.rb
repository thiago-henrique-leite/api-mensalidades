RSpec.describe StudentSerializer do
  describe '#as_json' do
    let(:student) { create(:student) }
    let(:enrollments) { student.enrollments.map { |enrollment| EnrollmentSerializer.new(enrollment).attributes } }

    subject { described_class.new(student).as_json }

    before do
      create(:enrollment, student: student)
    end

    it do
      is_expected.to eq({
        id: student.id,
        birthdate: student.birthdate,
        cpf: student.cpf,
        name: student.name,
        payment_method: student.payment_method,
        enrollments: enrollments
      })
    end
  end
end
