class GoalsController < ApplicationController

  before_action :set_list, only: [:show, :edit, :update]
  before_action :set_goal, only: [:show, :edit, :update, :destroy, :image_destroy]

  def new
    @goal = Goal.new
    @goal.categories.new                 # 新規カテゴリ作成用
    @list = List.find(params[:list_id])  # 画面遷移用
  end

  def create
    @goal = Goal.new(goal_params)
    @list = List.find(@goal.list_id)           # 画面遷移用
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
    @goal_categories = @goal.categories.order("category_name ASC")
  end

  def edit
    if @goal.user_id == current_user.id
      @categories = Category.includes(:goals) # セレクトボックス用
    else
      redirect_to root_path
    end
  end

  def update
    update_ids = params[:goal][:category_ids] # チェックボックスで選択されたカテゴリのidを取得

    # 新規カテゴリが追加された場合
    if params[:goal][:categories_attributes] != nil
      added_categories = params[:goal][:categories_attributes][:"0"][:"category_name"].split(/[, 、　]/)
      if @goal.update(goal_params)
        @goal.update_category(added_categories, update_ids)
        flash[:success] = "#{@goal.title}を更新しました"
        redirect_to list_goal_path(@goal.list_id, @goal.id)
      else
        flash.now[:alert] = @goal.errors.full_messages
        render action: :edit
      end
      # 新規カテゴリの入力がない場合
    else
      if @goal.update(goal_params)
        flash[:success] = "#{@goal.title}を更新しました"
        redirect_to list_path(@list)
      else
        flash.now[:alert] = @goal.errors.full_messages
        render action: :edit
      end
    end
  end

  def destroy
    if @goal.user_id == current_user.id
      @goal.destroy
      redirect_to list_path(@goal.list_id), notice: "#{@goal.title}を削除しました"
    else
      redirect_to root_path
    end
  end

  def image_destroy
    if @goal.user_id == current_user.id && @goal.image.attached?
      @goal.image.purge
      redirect_to action: :edit and return
    else
      render action: :edit
    end
    # respond_to do |format|
    #   format.html
    #   format.json
    # end
  end

  def destroy_at_root
    # if @goal.user_id == current_user.id
      # @goal.destroy
      # redirect_to root_path, notice: "#{@goal.title}を削除しました"
    # else
      # redirect_to root_path
    # end
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :image, :status, :list_id, :user_id, :date, category_ids: [], categories_attributes: [:category_name, :user_id])
  end

  def set_list
    @goal = Goal.find(params[:id])
    @list = List.find(@goal.list_id)
    # @list = List.find(params[:id])だとゴールのidを取得してしまう
  end

  def set_goal
    @goal = Goal.find(params[:id])
  end

end
