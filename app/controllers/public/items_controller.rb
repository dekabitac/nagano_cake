class Public::ItemsController < ApplicationController

  def index
    @items = Item.all.page(params[:page]).per(12)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @customer = current_customer
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to customer_path
  end

  private

  def customer_params
    params.require(:item).permit(:product_name, :introduction, :genre_id, :price, :is_active)
  end

  def order_detaile_params
    params.require(:order_detaile).permit(:amount)
  end

end
