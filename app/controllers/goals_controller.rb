class GoalsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update]
  before_action :set_goal, only: [:show, :edit, :update]
  before_action :set_goal_categories, only: [:show]

  def new
    @goal = Goal.new
    @goal.categories.new                 # 新規カテゴリ作成用
    @list = List.find(params[:list_id])  # 画面遷移用
  end

  def create
    @goal = Goal.new(goal_params)
    @list = List.find(@goal.list_id) # 画面遷移用
    checked_ids = params[:goal][:category_ids] # チェックボックスのカテゴリのidを取得

    # 新規カテゴリの入力がある場合
    if params[:goal][:categories_attributes] != nil
      inputs = params[:goal][:categories_attributes][:"0"][:"category_name"].split(/[, 、　]/) # 区切り文字で分割、配列化
      if @goal.save
        @goal.save_category(inputs, checked_ids)
        flash[:success] = "タスクを作成しました"
        redirect_to list_path(@list)
      else
        flash.now[:alert] = @goal.errors.full_messages
        render action: :new
      end
    # 新規カテゴリの入力がない場合
    else
      if @goal.save
        flash[:success] = "タスクを作成しました"
        redirect_to list_path(@list)
      else
        flash.now[:alert] = @goal.errors.full_messages
        render action: :new
      end
    end

  end

  def show
  end

  def edit
    @categories = Category.includes(:goals) # セレクトボックス用
  end

  def update
    # set_goalで更新するレコードの情報を取得
    checked_ids = params[:goal][:category_ids]
    if params[:goal][:categories_attributes] != nil
      inputs = params[:goal][:categories_attributes][:"0"][:"category_name"].split(/[, 、　]/) # 区切り文字で分割、配列化
      if @goal.update(goal_params)
        @goal.save_category(inputs, checked_ids)
        flash[:success] = "#{@goal.title}を更新しました"
        redirect_to @goal
      else
        flash.now[:alert] = @goal.errors.full_messages
        render action: :edit
      end
      # 新規カテゴリの入力がない場合
    else
      if @goal.update!(goal_params)
        flash[:success] = "#{@goal.title}を更新しました"
        redirect_to list_path(@list)
      else
        flash.now[:alert] = @goal.errors.full_messages
        render action: :edit
      end
    end
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :list_id, :date, category_ids: [], categories_attributes: [:category_name])
  end

  def set_list
    @goal = Goal.find(params[:id])
    @list = List.find(@goal.list_id)
    # @list = List.find(params[:id])だとゴールのidを取得してしまう
  end

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def set_goal_categories
    @goal = Goal.find(params[:id])
    @goal_categories = @goal.categories
  end
end
