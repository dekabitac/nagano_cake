class Item < ApplicationRecord
  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :order_detailes
  belongs_to :genre

  validates :product_name, presence: true
  validates :genre, presence: true
  validates :price, presence: true

  def with_tax_price
    (price * 1.1).floor
  end

end
