class ProductsController < ApplicationController
  before_action :set_product, only: [:configure, :update]
  before_action :require_admin!
  def index
    @products = Product.all.order(:id)
    @product  = Product.new
  end
  def new
    @product = Product.new
    render partial: "new_modal", locals: { product: @product }
  end
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_path, notice: "Product added"
    else
      redirect_to products_path, alert: "Name cannot be blank."
    end
  end

  def configure
    render partial: "modal", locals: { product: @product }
  end


  def update
    if @product.update(product_params)
      redirect_to products_path, notice: "Product updated!"
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
  def product_params
    params.require(:product).permit(:name)
  end

  def require_admin!
    redirect_to root_path, alert: "Access denied" unless current_user.is_admin?
  end
end
