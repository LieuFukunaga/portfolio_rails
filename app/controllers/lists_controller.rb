class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = List.includes(:user).order("list_name ASC").page(params[:page]).per(10)

    tasks = Goal.order("date DESC").select{|d| d.date >= Time.now}.select{|d|d.date <= Time.now + 1.week}
    @tasks = tasks.delete_if { |task| task.user_id != current_user.id }
    @next_seven_days = Date.today + 1.week
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      flash[:success] = "リストを作成しました"
      redirect_to root_path
    else
      flash.now[:alert] = @list.errors.full_messages
      render new_list_path
    end
  end

  def show
    @goals = @list.goals.order("title ASC").page(params[:page]).per(6)
  end

  def edit
    if @list.user_id != current_user.id
      redirect_to root_path
    end
  end

  def update
    if @list.update(list_params)
      flash[:success] = "#{@list.list_name}を更新しました"
      redirect_to root_path
    else
      flash.now[:alert] = @list.errors.full_messages
      render action: :edit
    end
  end

  def destroy
    if @list.user_id == current_user.id
      @list.destroy
      redirect_to root_path, notice: "#{@list.list_name}を削除しました"
    else
      redirect_to root_path
    end
  end

  def list_search
    # ソート機能用
    if params[:sort] == "/lists/list_search"
      list_sort = "created_at DESC"
    else
      list_sort = params[:sort]
    end

    # 検索機能用
    user_id = current_user.id
    @lists = List.order(list_sort).list_search(params[:keyword], user_id)
    @keywords = List.split_keyword(params[:keyword])

  end

  def task_search
    user_id = current_user.id
    @tasks = List.task_search(params[:keyword], user_id)
    respond_to do |format|
      format.html
      format.json
    end
  end

  # def change_status
  #   @gaols = List.find(params[:id]).goals
  #   respond_to do |format|
  #     format.html
  #     format.json
  #   end
  # end

  private

  def list_params
    params.require(:list).permit(:list_name).merge(user_id: current_user.id)
  end

  def set_list
    @list = List.find(params[:id])
  end


end
