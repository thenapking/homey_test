class ProjectCommentsController < ApplicationController
  before_action :set_project

  def create
    @comment = @project.project_comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @project, notice: 'Comment was successfully added.'
    else
      redirect_to @project, alert: 'Comment could not be added.'
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def comment_params
    params.require(:project_comment).permit(:comment)
  end
end
