class OrdersController < ApplicationController
  def create
    service = CreateOrderService.new(order_params)
    result = service.call

    if result[:success]
      render json: { order: result[:order] }, status: :created
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.permit(:product_id, :email, :name, :quantity)
  end
end
