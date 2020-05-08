class GoalsController < ApplicationController
  before_action :set_list, only: [:show, :edit]
  before_action :set_goal, only: [:show, :edit]
  before_action :set_category, only: [:show, :edit]

  def index
    @goals = List.includes(:goals)
  end

  def new
    @goal = Goal.new
    @categories = Category.all                # セレクトボックス用
    @goal.categories.new                      # 新規カテゴリ作成用
    @list_id = List.find(params[:list_id]).id # 画面遷移用

  end

  def create
    @goal = Goal.new(goal_params)
    @list = List.find(params[:goal][:list_id]) # 画面遷移用
    checked_ids = params[:goal][:category_ids] # チェックボックスのカテゴリのidを取得

    # 新規カテゴリの入力がある場合
    if params[:goal][:categories_attributes] != nil
      inputs = params[:goal][:categories_attributes][:"0"][:"category_name"].split(/[, 、　]/) # 区切り文字で分割、配列化
      if @goal.save
        @goal.save_category(inputs, checked_ids)
        flash[:success] = "タスクを作成しました"
        redirect_to list_path(@list.id)
      else
        flash.now[:alert] = @goal.errors.full_messages
        render action: :new
      end
    # 新規カテゴリの入力がない場合
    else
      if @goal.save
        flash[:success] = "タスクを作成しました"
        redirect_to list_path(@list.id)
      else
        flash.now[:alert] = @goal.errors.full_messages
        render action: :new
      end
    end

  end

  def show
  end

  def edit
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :list_id, :date, category_ids: [], categories_attributes: [:category_name])
    # params.require(:goal).permit(:title, :list_id, :date, category_ids: [])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def set_category
    @categories = @goal.categories
  end
end
