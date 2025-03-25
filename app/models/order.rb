class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  before_save :set_total_price, if: -> { product_id.present? && quantity.present? }
  after_create_commit :send_order_confirmation

  private

  def set_total_price
    self.total_price ||= product.price * quantity.to_i
  end

  def send_order_confirmation
    #NotificationMailer.order_confirmation(@order).deliver_later 
  end
end