class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    @lists = List.all
    @goals = List.includes(:goals)
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
    @goals = @list.goals
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
    if params[:keyword] != ""
      @lists = List.list_search(params[:keyword])
      @lists = @lists.where(user_id: current_user.id)
    else
      redirect_to root_path
    end
  end

  private
  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def list_params
    params.require(:list).permit(:list_name).merge(user_id: current_user.id)
  end

  def set_list
    @list = List.find(params[:id])
  end


end
