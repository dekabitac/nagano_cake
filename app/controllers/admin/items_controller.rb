class Admin::ItemsController < ApplicationController
before_action :authenticate_admin!, except: [:top, :about,:sign_in]
  def new
    @item = Item.new
    @genres = Genre.all
  end

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品の新規登録に成功しました"
      redirect_to admin_item_path(@item.id)
    else
      flash[:notice] = "商品の登録に失敗しました"
      redirect_to new_admin_item_path
    end

  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
     flash[:notice] = "商品を更新しました"
    redirect_to admin_item_path(item.id)
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :introduction, :genre_id, :price, :is_active)
  end

end
