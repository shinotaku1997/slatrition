class BodiesController < ApplicationController
  before_action :set_user, only: %i[new create show edit update]
  def new
    @body = @user.build_body
  end

  def create
    @body = @user.build_body(body_params)
    @body.goal.user_id = @user.id
    begin
    if @body.save!
      redirect_to root_path
      flash[:success] ="身体情報を登録しました。"
    else
      render :new
      flash[:danger] ="身体情報の登録に失敗しました。"
    end
    rescue => e
      logger.debug e.message
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
    body_params = params.require(:body).permit(:sex, :age, :weight, :height, goal_attributes: [:goal_weight, :volume_of_activity])
    body_params[:sex] = body_params[:sex].to_i if body_params[:sex].present?
    body_params[:goal_attributes][:volume_of_activity] = body_params[:goal_attributes][:volume_of_activity].to_i if body_params[:goal_attributes][:volume_of_activity].present?
    body_params
  end
end
