class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :status, 
    project_comments_attributes: [:id, :comment, :user_id], 
    project_statuses_attributes: [:id, :status, :user_id])
  end

  def set_status_updater
    return if params[:project][:project_statuses_attributes].nil?

    params[:project][:project_statuses_attributes].each do |status_attrs|
      status_attrs[:user_id] = current_user.id
    end
  end
end
