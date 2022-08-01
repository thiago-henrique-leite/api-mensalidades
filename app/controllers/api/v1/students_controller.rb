# frozen_string_literal: true

module Api
  module V1
    class StudentsController < ApplicationController
      def index
        return render json: Student.all if params[:page].nil? || params[:count].nil?

        students = Student.page(params[:page]).per(params[:count])

        render json: { page: params[:page], items: serialize_array(students) }, status: :ok
      end

      def show
        render json: student
      end

      def create
        student = Student.create(student_params)

        if student.save
          render json: { id: student.id }, status: :ok
        else
          render json: { error: student.errors }, status: :bad_request
        end
      end

      def update
        student.update!(student_params)

        render json: student, status: :ok
      end

      def destroy
        student.destroy!

        render json: {}, status: :no_content
      end

      private

      def student_id
        @student_id ||= params[:id]
      end

      def student
        @student ||= Student.find(student_id)
      end

      def student_params
        @student_params ||= params.permit(:birthdate, :cpf, :name, :payment_method)
      end

      def serialize_array(students)
        students.map { |student| StudentSerializer.new(student).as_json }
      end
    end
  end
end
