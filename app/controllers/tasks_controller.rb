class TasksController < ApplicationController
  before_action :set_tasks, only: %i[show edit update destroy]
  before_action :find_projects, only: %i[new create edit update]

  def index
    @tasks = Task.joins(:project).where(project: {creator_id: current_user.id}).includes([:project])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      respond_to do |format|
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.turbo_stream { flash.now[:notice] = "Task was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
    respond_to do |format|
      format.html { redirect_to @task, notice: "Task was successfully updated." }
      format.turbo_stream { flash.now[:notice] = "Task was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_path, notice: "Task was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Task was successfully destroyed." }
    end
  end

  private

  def find_projects
    @projects = Project.where(creator_id: current_user.id)
  end

  def set_tasks
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :project_id, report_attributes: [:title, :description])
  end
end
