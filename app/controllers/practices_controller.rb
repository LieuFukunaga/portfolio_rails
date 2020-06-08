class PracticesController < ApplicationController
  before_action :set_list, only: [:edit, :update, :reset]
  before_action :set_goal, only: [:edit, :update, :reset]
  before_action :set_step, only: [:edit]
  before_action :set_steps, only: [:edit]
  before_action :set_practice, only: [:edit, :update, :change_status, :destroy_image, :reset]

  def edit
    @practices = Practice.where(goal_id: @goal.id)
    @categories = @goal.categories
  end

  def update
    binding.pry
    if @practice.update(practice_params)
      flash[:success] = "#{@practice.title}を更新しました"
      redirect_to list_goal_path(@list, @goal)
    else
      flash.now[:alert] = @practice.errors.full_messages
      render action: :edit
    end
  end

  def destroy
  end

  # タスク詳細ページ・practices用
  def change_status
    if @practice.user_id == current_user.id
      status = params[:status]
      if status == "doing"
        @practice.update(status: "done")
      else
        @practice.update(status: "doing")
      end
      respond_to do |format|
        format.json {render json: @practice}
      end
    end
  end

  def destroy_image
    if @practice.user_id == current_user.id && @practice.practice_image.attached?
      @practice.practice_image.purge
    else
      render action: :edit
    end
  end

  def reset
    if @practice.user_id == current_user.id
      if @practice.practice_image.attached?
        @practice.practice_image.purge
        @practice.update(title: "actions", status: "doing")
        redirect_to list_goal_path(@list, @goal)
      else
        @practice.update(title: "actions", status: "doing")
        redirect_to list_goal_path(@list, @goal)
      end
    end
  end

  private

  def practice_params
    params.require(:practice).permit(:title)
  end

  def set_list
    @list = Practice.find(params[:id]).list
  end

  def set_goal
    @goal = Practice.find(params[:id]).goal
  end

  def set_step
    @step = Step.find(Practice.find(params[:id]).step.id)
  end

  def set_steps
    @steps = Step.where(goal_id: Practice.find(params[:id]).goal.id)
  end

  def set_practice
    @practice = Practice.find(params[:id])
  end

end
