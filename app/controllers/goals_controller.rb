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
    binding.pry
    # 作成されたリストに紐付けられたカテゴリをカンマで分割、配列にして変数に代入
    inputs = params[:goal][:categories_attributes][:"0"][:"category_name"].split(",")
    # respond_to do |format|
      if @goal.save!
        @goal.categorize(inputs)
        # format.html { redirect_to @goal, notice: 'リストを作成しました' } # showアクションにリダイレクト
        # format.json { render :show, status: :created, location: @goal }
        redirect_to root_path
      else
        format.html { render :new }
        format.json { render json: @goal.errors, status: :unprocessable_entity } # バリデーションに引っかかって保存できない旨を表示
      end
    # end
  end

  def show
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :list_id, :date, categories_attributes: [:category_name, :id, :_destroy])
  end
end
