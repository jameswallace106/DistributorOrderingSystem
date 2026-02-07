class ItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @order = Order.find(params[:order_id])
    @item = @order.items.create!(item_params)
    redirect_to configure_order_path(@order), status: :see_other
  end

  def destroy
    @item = Item.find(params[:id])
    @order = @item.order
    @item.destroy
    redirect_to configure_order_path(@order), status: :see_other
  end

  private

  def item_params
    params.permit(:stock_keeping_unit_id, :quantity)
  end
end
