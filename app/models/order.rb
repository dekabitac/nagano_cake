class Order < ApplicationRecord

  has_many :customers, dependent: :destroy
  has_many :order_details, dependent: :destroy


end
