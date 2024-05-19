class GoalsController < ApplicationController
  before_action :set_user, only: %i[new create show edit update]

  def new
    @goal = @user.build_goal
  end

  def create
    @goal =@user.build_goal(goal_params)
    if @goal.save
      redirect_to root_path
      flash[:success] = "目標の登録をしました。"
    else
      render :new
      flash[:danger] = "目標の登録に失敗しました。"
    end
  end

  def show;end

  def update;end

  def edit;end

  private
  def set_user 
    @user = User.find(params[:user_id])
  end

  def goal_params
    params[:goal].permit(:target_weight, :volume_of_activity )
  end
end
