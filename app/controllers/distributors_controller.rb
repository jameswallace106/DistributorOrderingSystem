class DistributorsController < ApplicationController
  before_action :set_distributor, only: [:destroy, :configure, :update]
  before_action :require_admin!
  def index
    @distributors = Distributor.all.order(:id)
  end

  def new
    @distributor = Distributor.new
    render partial: "new_modal", locals: { distributor: @distributor }
  end
  def create
    @distributor = Distributor.new(distributor_params)

    if @distributor.save
      redirect_to distributors_path, notice: "Distributor added"
    else
      flash.now[:alert] = "Failed to add distributor"
      render :new, status: :unprocessable_entity
    end
  end


  def destroy
    @distributor.destroy
    redirect_to distributors_path, notice: "Distributor deleted!"
  end
 
  def configure
    render partial: "modal", locals: { distributor: @distributor }
  end


  def update
    if @distributor.update(distributor_params)
      redirect_to distributors_path, notice: "Distributor updated!"
    end
  end

  private

  def set_distributor
    @distributor = Distributor.find(params[:id])
  end
  def distributor_params
    params.require(:distributor).permit(:name)
  end
  def require_admin!
    redirect_to root_path, alert: "Access denied" unless current_user.is_admin?
  end
end
