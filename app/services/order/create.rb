class Order
  class Create < BaseCreateService
    attr_reader :user

    def call
      super()

      return user if user.errors.any?
      resource
    end

    private

    def create_resource
      @user = User.find_or_initialize_by(email: params[:email])
      if user.new_record?
        user.name = params[:name]
        user.save
      end


      @resource = Order.create(
        user_id: user.id,
        product_id: params[:product_id],
        quantity: params[:quantity]
      )
    end
  end
end