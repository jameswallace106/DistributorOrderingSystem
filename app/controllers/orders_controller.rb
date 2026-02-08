class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:configure, :update, :destroy]
  before_action :load_skus, only: [:new, :configure]

  def index
    @orders = if current_user.is_admin?
      # Admins see only submitted orders
      Order.includes(:distributor).where(status: "submitted").order(created_at: :desc)
    else
      # Distributors see all orders for their distributor
      Order.includes(:distributor)
           .where(distributor_id: current_user.distributor_id)
           .order(created_at: :desc)
    end
  end

  def new
    return redirect_to orders_path, alert: "Access denied" if current_user.is_admin?
    @order = Order.create!(
      distributor: current_user.distributor,
      status: "in-progress",
      required_delivery_date: Date.current
    )

    load_skus
    render partial: "new_modal", locals: { order: @order, skus: @skus }
  end

  def create
    return redirect_to orders_path, alert: "Access denied" if current_user.is_admin?
    @order = Order.new(order_params)
    @order.distributor = current_user.distributor 
    if @order.save
      redirect_to orders_path, notice: "Order #{@order.status == 'submitted' ? 'submitted' : 'saved'}!"
    else
      load_skus
      flash.now[:alert] = @order.errors.full_messages.to_sentence
      render partial: "new_modal", 
             locals: { order: @order, skus: @skus },
             status: :unprocessable_entity
    end
  end

  def configure
    return redirect_to orders_path, alert: "Access denied" unless can_edit_order?

    render partial: "new_modal", locals: { order: @order, skus: @skus }
  end

  def view
    @order = Order.find(params[:id])
    render partial: "view_modal", locals: { order: @order, skus: @skus }
  end
  def update
    return redirect_to orders_path, alert: "Access denied" unless can_edit_order?

    if @order.update(order_params)
      redirect_to orders_path, notice: "Order #{@order.status == 'submitted' ? 'submitted' : 'updated'}!"
    else
      render partial: "new_modal", status: :unprocessable_entity
    end
  end

  def destroy
    return redirect_to orders_path, alert: "Access denied" unless can_edit_order?

    if @order.in_progress?
      @order.destroy
      redirect_to orders_path, notice: "Order deleted!"
    else
      redirect_to orders_path, alert: "Cannot delete submitted orders"
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def load_skus
    @skus = StockKeepingUnit.includes(:product)
                        .where(distributor_id: current_user.distributor_id)
  end

  def can_edit_order?
    return false if current_user.is_admin?
    return false if @order.submitted?
    @order.distributor_id == current_user.distributor_id
  end

  def order_params
    params.require(:order).permit(
      :required_delivery_date,
      :status,
      items_attributes: [:id, :quantity]
    )
  end
end
