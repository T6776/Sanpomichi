class User::UsersController < ApplicationController

  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_my_page_path, notice: "ユーザー情報を更新しました。"
    else
      render :edit
    end
  end

  def password_edit
    @user = current_user
  end

  def quit
    @user = current_user
  end

  def unsubscribe
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name,:email,:is_deleted)
  end

end
