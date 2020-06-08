class StepsController < ApplicationController
  before_action :set_list, only: [:edit, :update, :reset]
  before_action :set_goal, only: [:edit, :update, :reset]
  before_action :set_step, only: [:edit, :update, :change_status, :destroy_image, :reset]
  before_action :set_steps, only: [:edit, :update]
  before_action :set_practices, only: [:edit, :update]
  before_action :set_categories, only: [:edit, :update]

  def edit
    @steps = Step.where(goal_id: @goal.id)
  end

  def update
    if @step.user_id == current_user.id
      if @step.update(step_params)
        flash[:success] = "#{@step.title}を更新しました"
        redirect_to list_goal_path(@list, @goal)
      else
        flash.now[:alert] = @step.errors.full_messages
        render action: :edit
      end
    end
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

  def destroy_image
    if @step.user_id == current_user.id && @step.step_image.attached?
      @step.step_image.purge
    else
      render action: :edit
    end
  end

  def reset
    if @step.user_id == current_user.id
      if @step.step_image.attached?
        @step.step_image.purge
        @step.update(title: "steps", status: "doing")
        redirect_to list_goal_path(@list, @goal)
      else
        @step.update(title: "steps", status: "doing")
        redirect_to list_goal_path(@list, @goal)
      end
    end
  end

  private

  def step_params
    params.require(:step).permit(:title, :step_image, :status, :user_id, :list_id, :goal_id)
  end

  def set_list
    @list = Step.find(params[:id]).list
  end

  def set_goal
    @goal = Step.find(params[:id]).goal
  end

  def set_step
    @step = Step.find(params[:id])
  end

  def set_steps
    goal = Step.find(params[:id]).goal
    @steps = Step.where(goal_id: goal.id)
  end

  def set_practices
    @practices = []
    Step.where(goal_id: Step.find(params[:id]).goal.id).each do |step|
      step.practices.each do |practice|
        @practices << practice
      end
    end
  end

  def set_categories
    goal = Step.find(params[:id]).goal
    @categories = goal.categories
  end

end
