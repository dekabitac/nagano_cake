class Admin::OrdersController < ApplicationController
before_action :authenticate_admin!, except: [:top, :about,:sign_in]
  def show
  @order = Order.find(params[:id])
  @customer = @order.customer
  @sum = 0
  end

  def update
  end

  def order_params
    params.require(:order).permit(:amount, :address, :addressee, :payment_method, :billing_amount, :shipping_cost, :postal_code, :created_at, :update_at)
  end

end
