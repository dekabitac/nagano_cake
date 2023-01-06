class Public::AddressesController < ApplicationController

  def index
    @addresses = current_customer.addresses
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    if address = Address.new(address_params)
      address.save
      address.customer_id = current_customer.id
      address.save
      redirect_to public_addresses_path
    else
      redirect_to public_addresses_path
    end
  end

  def update
    address = Address.find(params[:id])
    address.update(address_params)
    redirect_to public_addresses_path
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
  end

  private

  def address_params
    params.require(:address).permit(:addressee, :postal_code, :address)
  end



end
