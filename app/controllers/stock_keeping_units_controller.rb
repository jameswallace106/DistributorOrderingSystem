class StockKeepingUnitsController < ApplicationController
  before_action :set_sku, only: [:destroy, :configure, :update]

  def index
    @skus = StockKeepingUnit.includes(:distributor, :product).order(:id)
    @distributors = Distributor.all.order(:name)
    @products = Product.all.order(:name)
  end

  def new
    @sku = StockKeepingUnit.new
    @distributors = Distributor.all.order(:name)
    @products = Product.all.order(:name)
    render partial: "new_modal", locals: { sku: @sku, distributors: @distributors, products: @products }
  end
  def create
    @sku = StockKeepingUnit.new(sku_params)
    if @sku.save
      redirect_to stock_keeping_units_path, notice: "SKU added"
    else
      flash.now[:alert] = "Failed to add SKU"
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @sku.destroy
    redirect_to stock_keeping_units_path, notice: "SKU deleted!"
  end

  def configure
    @distributors = Distributor.all.order(:name)
    @products = Product.all.order(:name)
    render partial: "modal", locals: { sku: @sku, distributors: @distributors, products: @products }
  end

  def update
    if @sku.update(sku_params)
      redirect_to stock_keeping_units_path, notice: "SKU updated!"
    else
      @distributors = Distributor.all.order(:name)
      @products = Product.all.order(:name)
      render partial: "modal", locals: { sku: @sku, distributors: @distributors, products: @products }, status: :unprocessable_entity
    end
  end

  private

  def set_sku
    @sku = StockKeepingUnit.find(params[:id])
  end

  def sku_params
    params.require(:stock_keeping_unit).permit(:price, :distributor_id, :product_id)
  end
end