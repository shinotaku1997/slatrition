class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :require_login, only: %i[new create]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      flash[:success]= "アカウント登録に成功しました。"
      redirect_to new_user_body_path(@user)
    else
      flash[:danger]= "アカウント登録に失敗しました。"
      Rails.logger.info @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def brm
    #男性の場合
    #13.397*weight+4.999*height-5.677*age*+8.367
    #女性の場合
    #9.247×weight＋3.098×height−4.33×age+447.593
  end

  def show
    @user =User.find(params[:id])
  end

  def edit
    @user= User.find(params[:id])
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
