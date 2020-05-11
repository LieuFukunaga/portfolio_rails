class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.includes(:goals)
  end

  def show
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

  def destroy
    @category.destroy
    redirect_to categories_path, notice: "#{@category.category_name}を削除しました"
  end

  private

  def category_params
    params.require(:category).permit(:category_name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end
