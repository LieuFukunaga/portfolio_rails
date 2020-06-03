class ActionsController < ApplicationController

  # タスク詳細ページ・actions用
  def change_status
    @action = Action.find(params[:id])
    if @action.user_id == current_user.id
      status = params[:status]
      if status == "doing"
        @action.update(status: "done")
      else
        @action.update(status: "doing")
      end
      respond_to do |format|
        format.json {render json: @action}
      end
    end
  end

end
