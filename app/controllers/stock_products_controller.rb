class StockProductsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @products = Product.all
  end
end
