class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def sale_price
    # Calculate by subtracting the active sales percent off integer divided by 100 from 1
    sale_price = price * (1 - (Sale.active.first.percent_off.to_f / 100))
  end
end
