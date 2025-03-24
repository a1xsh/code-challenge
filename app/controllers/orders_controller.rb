class OrdersController < BaseController
  private

  def resource_params
    params.permit(:name, :email, :product_id, :quantity)
  end
end