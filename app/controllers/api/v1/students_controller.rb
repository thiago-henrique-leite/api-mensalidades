# frozen_string_literal: true

module Api
  module V1
    class StudentsController < ApplicationController
      def index
        render json: students
      end

      def show
        render json: student
      end

      def create
        student = Student.create(student_params)

        return render json: student if student.save

        render json: { error: student.errors }, status: :bad_request
      end

      def update
        student.update!(student_params)

        render json: student
      end

      def destroy
        student.destroy!

        render json: {}, status: :no_content
      end

      private

      def student
        @student ||= Student.find(params[:id])
      end

      def students
        @students ||= Student.page(page).per(count)
      end

      def student_params
        params.permit(:birthdate, :cpf, :name, :payment_method)
      end
    end
  end
end
