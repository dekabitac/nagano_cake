class Public::CartItemsController < ApplicationController
before_action :authenticate_customer!, except: [:top, :about, :sign_up, :sign_in, :index, :show]
  def index
    @cart_items = current_customer.cart_items
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += cart_item.amount * cart_item.item.with_tax_price
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to public_cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.customer_id == current_customer.id
    cart_item.destroy
    redirect_to public_cart_items_path
    end
  end

  def destroy_all
    cart_item = current_customer.cart_items
    cart_item.destroy_all
    redirect_to public_cart_items_path, notice: 'カートが空になりました。'
  end

  def create
    @item =CartItem.new(cart_item_params)
    @cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: @item.item_id)
    if @cart_item
      @total_item = @cart_item.amount + @item.amount
      @cart_item.update(amount: @total_item)
    else
      @item.save

    end
    redirect_to public_cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id,:customer_id, :amount)
  end


end
