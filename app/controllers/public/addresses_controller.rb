class Public::AddressesController < Public::ApplicationController

  def index
    @address = Address.new
    @addresses = Current.customer.addresses
  end  

  def create
    @address = Current.customer.addresses.new(address_params)

    if @address.save
      redirect_to addresses_path
    else
      @addresses = Current.customer.addresses.reload
      render :index, status: :unprocessable_entity
    end  
  end 
  
  def edit
    @address = Current.customer.addresses.find(params[:id])
  end  


  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end


