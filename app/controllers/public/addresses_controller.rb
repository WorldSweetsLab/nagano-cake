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

  def update
    @address = Current.customer.addresses.find(params[:id])

    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先情報を変更しました"
    else
      flash.now[:alert] = "配送先情報を変更できません"
      render :edit, status: :unprocessable_entity
    end
  end 
  
  def destroy
    @address = Current.customer.addresses.find(params[:id])
    @address.destroy
    redirect_to addresses_path, notice: "配送先情報を削除しました"
  end  


  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end


