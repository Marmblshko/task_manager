class TasksController < ApplicationController
  before_action :set_tasks, only: %i[show edit update destroy]
  before_action :find_projects, only: %i[new create edit update]
  before_action :load_tasks, only: %i[index]

  def index
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.creator_id = current_user.id
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
    @reports = @task.reports
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

  def load_tasks
    @tasks = if current_user.role == "Admin"
               Task.all.includes(:project)
             else
               my_projects = Project.where(creator_id: current_user.id)
               tasks_in_my_projects = Task.joins(:project).where(project_id: my_projects.pluck(:id))
               tasks_with_current_user = Task.joins(:project).includes(:project).select { |task| task.project.users_in_project.include?(current_user.id) }
               (tasks_in_my_projects + tasks_with_current_user).uniq
             end

  end

  def find_projects
    @projects = Project.where(Project.arel_table[:users_in_project].contains([current_user.id])).or(Project.where(creator_id: current_user.id)).includes([:users])
  end

  def set_tasks
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :project_id, reports_attributes: [:title, :description])
  end
end
