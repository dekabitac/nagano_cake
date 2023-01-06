class Public::CustomersController < ApplicationController
before_action :authenticate_customer!, except: [:top, :about, :sign_up, :sign_in, :index, :show]
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
     customer_id = params[:id].to_i
  login_customer_id = current_customer.id
  if(customer_id != login_customer_id)
    redirect_to public_items_path
  end
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
     flash[:notice] = "会員情報を更新しました"
    redirect_to public_customer_path(customer.id)
  end

  def confirmation
    @customer = current_customer
  end

  def withdrawal
    current_customer.update(is_deleted: true)
    reset_session
    flash[:notice] = '退会処理の実行に成功しました'
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:email, :last_name,
    :first_name,:last_name_kana, :first_name_kana, :postal_code,
    :address, :telephone_number, :is_deleted)
  end


end
