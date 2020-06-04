class StepsController < ApplicationController
  before_action :set_step, only: [:edit, :update, :change_status]

  def edit
    @list = @step.list
    @goal = @step.goal
    @steps = Step.where(goal_id: @goal.id)
  end

  def update
  end

  def destroy
  end

  # タスク詳細ページ・steps用
  def change_status
    if @step.user_id == current_user.id
      status = params[:status]
      if status == "doing"
        @step.update(status: "done")
      else
        @step.update(status: "doing")
      end
      respond_to do |format|
        format.json {render json: @step}
      end
    end
  end

  private

  def set_step
    @step = Step.find(params[:id])
  end

end
