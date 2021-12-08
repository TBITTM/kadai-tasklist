class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  

  def show
     @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end


  

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
  
end
