class StockKeepingUnitsController < ApplicationController
  before_action :set_sku, only: [ :configure, :update]

  def index
    @skus = if current_user.is_admin?
      StockKeepingUnit.includes(:product, :distributor).all
    else
      StockKeepingUnit.includes(:product, :distributor)
                      .where(distributor_id: current_user.distributor_id)
    end
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
      redirect_to stock_keeping_units_path, alert: "Name cannot be blank."
    end
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