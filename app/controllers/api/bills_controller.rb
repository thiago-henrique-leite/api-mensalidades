class Api::BillsController < ApplicationController
  def index
    render json: bills
  end

  def show
    render json: bill
  end

  def update
    bill.update!(bill_params)

    render json: bill
  end

  def destroy
    bill.destroy!

    render json: {}, status: :no_content
  end

  private

  def bill
    @bill ||= Bill.find(params[:id])
  end

  def bills
    @bills ||= Bill.page(page).per(count)
  end

  def bill_params
    params.permit(:amount, :due_date, :status, :enrollment_id)
  end
end
