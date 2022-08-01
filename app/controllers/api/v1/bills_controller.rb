# frozen_string_literal: true

module Api
  module V1
    class BillsController < ApplicationController
      def index
        return render json: Bill.all if params[:page].nil? || params[:count].nil?

        bills = Bill.page(params[:page]).per(params[:count])

        render json: { page: params[:page], items: serialize_array(bills) }, status: :ok
      end

      def show
        render json: bill
      end

      def update
        bill.update!(bill_params)

        render json: bill, status: :ok
      end

      def destroy
        bill.destroy!

        render json: {}, status: :no_content
      end

      private

      def bill_id
        @bill_id ||= params[:id]
      end

      def bill
        @bill ||= Bill.find(bill_id)
      end

      def bill_params
        @bill_params ||= params.permit(:amount, :due_date, :status, :enrollment_id)
      end

      def serialize_array(bills)
        bills.map { |bill| BillSerializer.new(bill).as_json }
      end
    end
  end
end
