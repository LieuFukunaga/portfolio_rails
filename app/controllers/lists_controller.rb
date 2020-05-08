class ListsController < ApplicationController

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
      redirect_to root_path
    else
      render new_list_path
    end
  end

  def show
    @list = List.find(params[:id])
    @goals = @list.goals
  end

  private
  def list_params
    params.require(:list).permit(:list_name).merge(user_id: current_user.id)
  end
end
