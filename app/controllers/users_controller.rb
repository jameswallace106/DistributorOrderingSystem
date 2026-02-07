class UsersController < ApplicationController
  before_action :set_user, only: [:configure, :update, :destroy]
  before_action :load_associations, only: [:new, :configure]
  before_action :require_admin!
  def index
    @users = User.includes(:distributor, :admin).order(:id)
  end

  def new
    @user = User.new
    render partial: "new_modal", locals: { user: @user, distributors: @distributors, admins: @admins }
  end

def create
  @user = User.new(user_create_params)

  if @user.save
    redirect_to users_path, notice: "User added"
  else
    flash.now[:alert] = @user.errors.full_messages.to_sentence
    load_associations
    render partial: "new_modal",
           locals: { user: @user, distributors: @distributors, admins: @admins },
           status: :unprocessable_entity
  end
end

  def configure
    render partial: "modal", locals: { user: @user, distributors: @distributors, admins: @admins }
  end

  def update
    # Build params hash conditionally
    update_params = user_update_params
    # If password fields are blank, remove them so Devise doesn't try to update
    if update_params[:password].blank?
      update_params.delete(:password)
      update_params.delete(:password_confirmation)
    end

    # Save user
    success =
      if update_params[:password].present?
        @user.update(update_params)
      else
        @user.update_without_password(update_params)
      end

    if success
      redirect_to users_path, notice: "User updated!"
    else
      load_associations
      render partial: "modal",
            locals: { user: @user, distributors: @distributors, admins: @admins },
            status: :unprocessable_entity
    end
  end

  def destroy
    if @user == current_user
      redirect_to users_path, alert: "You cannot delete yourself!"
    else
      @user.destroy
      redirect_to users_path, notice: "User deleted!"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def load_associations
    @distributors = Distributor.order(:name)
    @admins = Admin.order(:name)
  end

  def user_create_params
    params.require(:user).permit(:username, :is_admin, :distributor_id, :admin_id, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:username, :is_admin, :distributor_id, :admin_id, :password, :password_confirmation)
  end

  def require_admin!
    redirect_to root_path, alert: "Access denied" unless current_user.is_admin?
  end
end
