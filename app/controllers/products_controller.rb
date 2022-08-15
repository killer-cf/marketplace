class ProductsController < ApplicationController
  before_action :set_product, only: %i[show activate deactivate]

  def index
    @products = admin_signed_in? ? Product.all : Product.active
  end

  def show
    @product_stock = @product.stock_products.count
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: t('product_created')
    else
      render :new
    end
  end

  def activate
    @product.active!
    redirect_to @product, notice: t('product_activated_successfully')
  end

  def deactivate
    @product.inactive!
    redirect_to @product, notice: t('product_deactivated_successfully')
  end

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: t('inactive_or_inexistent_product')
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :brand, :width,
                                    :height, :depth, :weight, :sku, photos: [])
  end
end
