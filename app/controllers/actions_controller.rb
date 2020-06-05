class ActionsController < ApplicationController
  before_action :set_action, only: [:edit, :update, :change_status, :destroy_image]

  def edit
    @list = @action.list
    @goal = @action.goal
    @step = @action.step
    @actions = Action.where(goal_id: @goal.id)
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

  private

  def set_action
    @action = Action.find(params[:id])
  end

end
