class ProductsController < ApplicationController
  before_action :set_product, only: [:destroy, :configure, :update]
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
      flash.now[:alert] = "Failed to add product"
      render :new, status: :unprocessable_entity
    end
  end


  def destroy
    @product.destroy
    redirect_to products_path, notice: "Product deleted!"
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
end
