class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  enum :payment_method, { credit_card: 0, transfer: 1 }

  enum :status, { waiting_for_payment: 0, paid_confirmation: 1, making: 2, preparing: 3, shipped: 4}

  SHIPPINGCOST = 800

  def calculate_total_payment(cart_items)
    self.shipping_cost = SHIPPINGCOST

    subtotal = cart_items.sum do |cart_item|
      cart_item.item.with_tax_price*cart_item.amount
    end
    self.total_payment = subtotal + shipping_cost
  end  
end
