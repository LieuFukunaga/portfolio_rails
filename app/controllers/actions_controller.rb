class ActionsController < ApplicationController
  before_action :set_list, only: [:edit, :reset]
  before_action :set_goal, only: [:edit, :reset]
  before_action :set_step, only: [:edit]
  before_action :set_action, only: [:edit, :update, :change_status, :destroy_image, :reset]

  def edit
    @actions = Action.where(goal_id: @goal.id)
    @categories = @goal.categories
  end

  def update
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

  def set_list
    @list = Action.find(params[:id]).list
  end

  def set_goal
    @goal = Action.find(params[:id]).goal
  end

  def set_step
    @step = Action.find(params[:id]).step
  end

  def set_action
    @action = Action.find(params[:id])
  end

end
