class ProjectsController < ApplicationController
  before_action :set_project, only: %i(show edit update destroy)
  def index
    @projects = Project.where(creator_id: current_user.id)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.creator_id = current_user.id
    if @project.save
      Membership.create(user_id: current_user.id, project_id: @project.id)
      redirect_to @project
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to project_path
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description)
  end
end
