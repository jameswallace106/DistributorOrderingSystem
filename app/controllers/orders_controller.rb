class OrdersController < ApplicationController
  def index
    @orders = Order.includes(:user, :distributor).order(created_at: :desc)
  end
end
