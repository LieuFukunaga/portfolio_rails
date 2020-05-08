class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:goals)
  end

  def show
    @category = Category.find(params[:id])
    @goals = @category.goals
  end
end
