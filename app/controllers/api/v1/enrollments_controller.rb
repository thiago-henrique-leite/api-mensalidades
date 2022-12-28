module Api
  module V1
    class EnrollmentsController < ApplicationController
      http_basic_authenticate_with name: Settings.basic_auth.username,
                                   password: Settings.basic_auth.password

      def index
        render json: enrollments
      end

      def show
        render json: enrollment
      end

      def create
        enrollment = Enrollment.create(enrollment_params)

        return render json: enrollment if enrollment.save

        render json: { error: enrollment.errors }, status: :bad_request
      end

      def update
        enrollment.update!(enrollment_params)

        render json: enrollment
      end

      def destroy
        enrollment.destroy!

        render json: {}, status: :no_content
      end

      private

      def enrollment
        @enrollment ||= Enrollment.find(params[:id])
      end

      def enrollments
        @enrollments ||= Enrollment.page(page).per(count)
      end

      def enrollment_params
        params.permit(:amount, :due_day, :installments, :student_id)
      end
    end
  end
end
