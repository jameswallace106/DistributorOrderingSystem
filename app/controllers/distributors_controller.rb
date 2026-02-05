class DistributorsController < ApplicationController
  before_action :set_distributor, only: [:destroy, :configure, :update]
  def index
    @distributors = Distributor.all.order(:id)
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
    else
      render partial: "modal", locals: { distributor: @distributor }, status: :unprocessable_entity
    end
  end

  private

  def set_distributor
    @distributor = Distributor.find(params[:id])
  end
  def distributor_params
    params.require(:distributor).permit(:username)
  end
end
