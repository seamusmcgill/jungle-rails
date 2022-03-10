class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
  end

  def sale_price
    # Calculate by subtracting the active sales percent off integer divided by 100 from 1
    sale_price = price * (1 - (active_sale?.percent_off.to_f / 100))
  end
  helper_method :sale_price

end
