class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update]
  before_action :set_categories, only: [:index]

  def index
  end

  def show
    @goals = @category.goals
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path
      flash[:success] = "カテゴリを更新しました"
    else
      flash.now[:alert] = @category.errors.full_messages
      render action: :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:category_name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def set_categories
    @categories = Category.includes(:goals)
  end
end
