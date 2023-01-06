class Admin::HomesController < ApplicationController
before_action :authenticate_admin!, except: [:top, :about,:sign_in]
  def top
    @orders = Order.page(params[:page]).per(10)
  end

  def about
  end

  private

  def order_params
    params.require(:order).permit(:amount, :address, :addressee, :payment_method, :billing_amount, :shipping_cost, :postal_code, :created_at, :update_at)
  end

end
