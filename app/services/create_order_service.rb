class CreateOrderService
  def initialize(params)
    @product_id = params[:product_id]
    @email = params[:email]&.to_s&.downcase
    @name = params[:name]
    @quantity = params[:quantity]
  end

  def call
    product = Product.find_by(id: @product_id)
    return error_result('Product not found') unless product

    user = User.find_by(email: @email) || create_user
    return error_result(user.errors.full_messages) if user.errors.any?

    order = Order.new(user: user, product: product, quantity: @quantity)
    
    if order.save
      { success: true, order: order, errors: [] }
    else
      { success: false, order: nil, errors: order.errors.full_messages }
    end
  rescue StandardError => e
    { success: false, order: nil, errors: [e.message] }
  end

  private

  def create_user
    User.create(name: @name, email: @email)
  end

  def error_result(errors)
    { success: false, order: nil, errors: Array(errors) }
  end
end