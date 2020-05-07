class GoalsController < ApplicationController
  def index
    @goals = List.includes(:goals)
  end

  def new
    @goal = Goal.new
    @goal.categories.new
    @list_id = List.find(params[:list_id]).id
  end

  def create
    @goal = Goal.new(goal_params)
    @list_id = List.find(params[:goal][:list_id]).id
    # カテゴリ有
    if params[:goal][:categories_attributes] != nil
      inputs = params[:goal][:categories_attributes][:"0"][:"category_name"].split(/[ 　,、]/) # 作成されたリストに紐付けられたカテゴリをカンマで分割、配列にして変数に代入
      if @goal.save
        @goal.save_category(inputs)
        flash[:success] = "タスクを作成しました"
        redirect_to list_path(@list_id)
      else
        flash.now[:alert] = @goal.errors.full_messages
        render action: :new
      end
    # カテゴリ無
    else
      if @goal.save
        flash[:success] = "タスクを作成しました"
        redirect_to list_path(@list_id)
      else
        flash.now[:alert] = @goal.errors.full_messages
        render action: :new
      end
    end
  end

  def show
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :list_id, :date, categories_attributes: [:category_name, :id, :_destroy])
  end
end
