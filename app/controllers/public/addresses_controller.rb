class Public::AddressesController < Public::ApplicationController

  def index
    @address = Current.customer.addresses.new
    @addresses = Current.customer.addresses
  end  

  def create
    @address = Current.customer.addresses.new(address_params)

    if @address.save
      redirect_to addresses_path
    else
      @addresses = Current.customer.addresses
      render :index, status: :unprocessable_entity
    end     
end


