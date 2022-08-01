# frozen_string_literal: true

module Api
  module V1
    class EnrollmentsController < ApplicationController
      before_action :authenticate, only: :create

      def index
        return render json: Enrollment.all if params[:page].nil? || params[:count].nil?

        enrollments = Enrollment.page(params[:page]).per(params[:count])

        render json: { page: params[:page], items: serialize_array(enrollments) }, status: :ok
      end

      def show
        render json: enrollment
      end

      def create
        enrollment = Enrollment.create(enrollment_params)

        if enrollment.save
          render json: enrollment, status: :ok
        else
          render json: { error: enrollment.errors }, status: :bad_request
        end
      end

      def update
        enrollment.update!(enrollment_params)

        render json: enrollment, status: :ok
      end

      def destroy
        enrollment.destroy!

        render json: {}, status: :no_content
      end

      private

      def authenticate
        self.class.http_basic_authenticate_with(
          name: Settings.basic_auth.username,
          password: Settings.basic_auth.password
        )
      end

      def enrollment_id
        @enrollment_id ||= params[:id]
      end

      def enrollment
        @enrollment ||= Enrollment.find(enrollment_id)
      end

      def enrollment_params
        @enrollment_params ||= params.permit(:amount, :due_day, :installments, :student_id)
      end

      def serialize_array(enrollments)
        enrollments.map { |enrollment| EnrollmentSerializer.new(enrollment).as_json }
      end
    end
  end
end
