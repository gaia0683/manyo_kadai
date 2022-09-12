class Admin::UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy]
  def index
    if current_user.admin_user == true
      @users = User.select(:name,:email,:password_digest,:id)
    else current_user.admin_user == false
      redirect_to tasks_path, notice: '管理者以外はアクセスできません'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    binding.pry

    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'ユーザーを編集しました！'
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'ユーザーを削除しました！'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:admin_user)
  end
end
