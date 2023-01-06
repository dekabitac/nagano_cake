class Public::OrdersController < ApplicationController
before_action :authenticate_customer!, except: [:top, :about, :sign_up, :sign_in, :index, :show]
  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @sum = 0
  end

  def new
    @order = Order.new

  end

  def confirmation
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @order.customer_id = current_customer.id
    @order.payment_method = params[:order][:payment_method]
    @order.shipping_cost = 800
    @total_payment = current_customer.cart_items.cart_items_total_price(@cart_items)
    @order.billing_amount = @order.shipping_cost + @total_payment
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.addressee = current_customer.first_name
      render :confirmation
    elsif params[:order][:address_option] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.addressee = @address.addressee
    elsif params[:order][:address_option] == "2"
      @address = current_customer.addresses.new
      @address.postal_code = params[:order][:postal_code]
      @address.address = params[:order][:address]
      @address.addressee = params[:order][:addressee]
      @address.customer_id = current_customer.id
      @address.save
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.addressee = @address.addressee
    end
  end

  def conpleted
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      order_detail = OrderDetaile.new(order_id:@order.id)
      order_detail.price = cart_item.item.price
      order_detail.amount = cart_item.amount
      order_detail.item_id = cart_item.item_id
      order_detail.save
    end
    @cart_items.destroy_all
    redirect_to customers_order_public_orders_path
  end


  private

  def order_params
    params.require(:order).permit(:amount, :address, :addressee, :payment_method, :billing_amount, :shipping_cost, :postal_code, :created_at, :update_at)
  end

  def address_params
    params.require(:address).permit(:addressee, :postal_code, :address)
  end
end
