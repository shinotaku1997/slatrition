class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

    def new
      @user = User.new
    end
    
    def create
      @user = login(params[:email], params[:password])
      if @user
        redirect_to root_path
        flash[:success] = "ログインしました"
      else
        render :new
        flash[:danger] = "ログインに失敗しました"
      end
    end
    
    def destroy
      logout
      redirect_to root_path
      flash[:success] = "ログアウトしました"
    end
end   