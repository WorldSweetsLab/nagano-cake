class Address < ApplicationRecord
  belongs_to :customer

  validates :address, presence: true
  validates :postal_code, presence: true
  validates :name, presence: true

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + name
  end







  private

  def address_params
    params.require(:address).permit(:address, :postal_code, :name)
  end  
end
