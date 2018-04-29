class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_current_user, except: [:show]

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # def destroy
  #   @user.destroy
  #   redirect_to users_path, notice: 'User was successfully destroyed.'
  # end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
