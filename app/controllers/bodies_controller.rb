class BodiesController < ApplicationController
  before_action :set_user, only: %i[new create show edit update]
  def new
    @user = User.find(params[:user_id])
    @body = @user.build_body
  end

  def create
    @body = @user.build_body(body_params)
    if @body.save
      redirect_to new_user_goal_path(@user)
      flash[:success] ="身体情報を登録しました。"
    else
      render :new
      flash[:danger] ="身体情報の登録に失敗しました。"
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private
  def set_user 
    @user = User.find(params[:user_id])
  end

  def body_params
    params[:body].permit(:sex, :age, :weight, :height)
  end
end
