class StepsController < ApplicationController

  # タスク詳細ページ・steps用
  def change_status
    @step = Step.find(params[:id])
    if @step.user_id == current_user.id
      status = params[:status]
      if status == "doing"
        @step.update(status: "done")
      else
        @step.update(status: "doing")
      end
      respond_to do |format|
        format.json {render json: @step}
      end
    end
  end

end
