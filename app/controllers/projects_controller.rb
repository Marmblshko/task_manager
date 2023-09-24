class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = if current_user.role == 'Admin'
                  Project.all
                else
                  Project.where(Project.arel_table[:users_in_project].contains([current_user.id]))
                         .or(Project.where(creator_id: current_user.id))
                end
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.creator_id = current_user.id
    @project.users_in_project = [current_user.id] if @project.users_in_project.blank?
    if @project.save
      Membership.create(user_id: current_user.id, project_id: @project.id)
      respond_to do |format|
        format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Project was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      respond_to do |format|
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.turbo_stream { flash.now[:notice] = 'Project was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Project was successfully destroyed.' }
      format.turbo_stream { flash.now[:notice] = 'Project was successfully destroyed.' }
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, users_in_project: [])
  end
end
