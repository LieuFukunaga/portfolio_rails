class ListsController < ApplicationController
  def index
  end

  #S3への画像アップロードテストに使用
  def new
    @list = List.new
  end

  def create
    @list = List.create params.require(:list).permit(:image)
    redirect_to @comment
  end

end
