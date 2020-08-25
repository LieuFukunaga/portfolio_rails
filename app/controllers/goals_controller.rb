class GoalsController < ApplicationController

  before_action :set_list, only: [:show, :edit, :update, :reset]
  before_action :set_goal, only: [:show, :edit, :update, :destroy, :root_destroy, :image_destroy, :change_status, :change_status_at_root, :reset]
  before_action :set_steps, only: [:show, :edit, :update]
  before_action :set_practices, only: [:show, :edit, :update]

  def new
    @goal = Goal.new

    @goal.categories.new                 # 新規カテゴリ作成用
    @goal.steps.new                 # 新規ステップ作成用
    @goal.practices.new                 # 新規アクション作成用

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
        steps = @goal.steps
        practices = @goal.practices

        practices[0..2].each do |practice|
          practice.update(step_id: steps[0].id)
        end
        practices[3..5].each do |practice|
          practice.update(step_id: steps[1].id)
        end
        practices[6..8].each do |practice|
          practice.update(step_id: steps[2].id)
        end

        @goal.save_category(inputs, checked_ids)
        flash[:success] = "タスクを作成しました"
        redirect_to list_path(@list)
      else
        flash[:alert] = @goal.errors.full_messages
        redirect_to list_path(@goal.list_id)
      end
      # 新規カテゴリの入力がない場合
    else
      if @goal.save
        steps = @goal.steps
        practices = @goal.practices

        practices[0..2].each do |practice|
          practice.update(step_id: steps[0].id)
        end
        practices[3..5].each do |practice|
          practice.update(step_id: steps[1].id)
        end
        practices[6..8].each do |practice|
          practice.update(step_id: steps[2].id)
        end
        flash[:success] = "タスクを作成しました"
        redirect_to list_path(@list)
      else
        flash[:alert] = @goal.errors.full_messages
        redirect_to list_path(@goal.list_id)
      end
    end
  end

  def show
    @categories = @goal.categories.order("category_name ASC")
  end

  def edit
    if @goal.user_id == current_user.id
      @categories = Category.where(user_id: current_user.id) # セレクトボックス用
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
        redirect_to action: :show
      else
        flash.now[:alert] = @goal.errors.full_messages
        render action: :edit
      end
      # 新規カテゴリの入力がない場合
    else
      if @goal.update(goal_params)
        flash[:success] = "#{@goal.title}を更新しました"
        redirect_to action: :show
      else
        flash.now[:alert] = @goal.errors.full_messages
        render action: :edit
      end
    end
  end

  def destroy
    if @goal.user_id == current_user.id
      @goal.destroy!
    end
  end



  # 画像削除のためのアクション
  def image_destroy
    if @goal.user_id == current_user.id && @goal.image.attached?
      @goal.image.purge
    else
      render action: :edit
    end
  end

  # リスト詳細ページ用
  def change_status
    if @goal.user_id == current_user.id
      status = params[:status]
      if status == "実行中"
        @goal.update(status: "done")
      else
        @goal.update(status: "doing")
      end
      respond_to do |format|
        format.html {redirect_to list_path(@goal.list_id)}
        format.json {render json: @goal}
      end
    end
  end

  # トップページタスク検索フォーム、タスク詳細ページ用
  def change_status_at_root
    if @goal.user_id == current_user.id
      status = params[:status]
      if status == "doing"
        @goal.update(status: "done")
      else
        @goal.update(status: "doing")
      end
      respond_to do |format|
        format.json
      end
    end
  end


  # リスト内タスク検索のため
  def task_search_in_list
    if params[:sort].nil?
      task_sort = "id DESC"
    else
      task_sort = params[:sort]
    end

    user_id = current_user.id
    list_id = List.find(params[:list_id]).id

    @tasks = Goal.order(task_sort).search_in_list(params[:keyword], user_id, list_id)
    @keywords = Goal.split_keyword(params[:keyword])

    @list_id = list_id
    @list_name = List.find(params[:list_id]).list_name
    @sort = task_sort
  end

  def reset
    if @goal.user_id == current_user.id
      if @goal.image.attached?
        @goal.image.purge
        @goal.update(title: "goal", status: "doing", date: Time.now + 1.hour, )
        redirect_to list_goal_path(@list, @goal)
      else
        @goal.update(title: "goal", status: "doing")
        redirect_to list_goal_path(@list, @goal)
      end
      if @goal.categories.length != 0
        @goal.update(category_ids: "")
      end
    end
  end



  private
  def goal_params
    params.require(:goal).permit(:title, :image, :status, :user_id, :list_id, :date, category_ids: [], categories_attributes: [:category_name, :user_id], steps_attributes: [:title, :step_image, :status, :user_id, :list_id, :goal_id], practices_attributes: [:title, :practice_image, :status, :user_id, :list_id, :goal_id, :step_id])
  end

  def set_list
    @list = Goal.find(params[:id]).list
  end

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def set_steps
    @steps = Goal.find(params[:id]).steps
  end

  def set_practices
    @practices = Goal.find(params[:id]).practices
  end

end