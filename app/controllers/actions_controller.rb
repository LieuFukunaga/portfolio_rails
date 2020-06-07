class ActionsController < ApplicationController
  before_action :set_list, only: [:edit, :update, :reset]
  before_action :set_goal, only: [:edit, :update, :reset]
  before_action :set_step, only: [:edit]
  before_action :set_steps, only: [:edit]
  before_action :set_action, only: [:edit, :update, :change_status, :destroy_image, :reset]

  def edit
    @actions = Action.where(goal_id: @goal.id)
    @categories = @goal.categories
  end

  def update
    binding.pry
    if @action.update(action_params)
      flash[:success] = "#{@action.title}を更新しました"
      redirect_to list_goal_path(@list, @goal)
    else
      flash.now[:alert] = @action.errors.full_messages
      render action: :edit
    end
  end

  def destroy
  end

  # タスク詳細ページ・actions用
  def change_status
    if @action.user_id == current_user.id
      status = params[:status]
      if status == "doing"
        @action.update(status: "done")
      else
        @action.update(status: "doing")
      end
      respond_to do |format|
        format.json {render json: @action}
      end
    end
  end

  def destroy_image
    if @action.user_id == current_user.id && @action.action_image.attached?
      @action.action_image.purge
    else
      render action: :edit
    end
  end

  def reset
    if @action.user_id == current_user.id
      if @action.action_image.attached?
        @action.action_image.purge
        @action.update(title: "actions", status: "doing")
        redirect_to list_goal_path(@list, @goal)
      else
        @action.update(title: "actions", status: "doing")
        redirect_to list_goal_path(@list, @goal)
      end
    end
  end

  private

  def action_params
    params.require(:action).permit(:title)
  end

  def set_list
    @list = Action.find(params[:id]).list
  end

  def set_goal
    @goal = Action.find(params[:id]).goal
  end

  def set_step
    @step = Step.find(Action.find(params[:id]).step.id)
  end

  def set_steps
    @steps = Step.where(goal_id: Action.find(params[:id]).goal.id)
  end

  def set_action
    @action = Action.find(params[:id])
  end

end
