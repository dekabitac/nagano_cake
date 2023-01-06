class Address < ApplicationRecord
  belongs_to :customer

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :addressee, presence: true

  def address_display
    '〒' + postal_code + ' ' + address + ' ' + addressee
  end

end
