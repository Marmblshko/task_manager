class ReportsController < ApplicationController
  before_action :set_report, except: %i[index]
  before_action :set_variable_report, only: %i[show edit update]

  def show
  end

  def new
    @report = @task.build_report
  end

  def create
    @report = @task.create_report(report_params)
    @task.report = @report
    if @report.save
      respond_to do |format|
        format.html { redirect_to @report.task, notice: "Report was successfully cr." }
        format.turbo_stream { flash.now[:notice] = "Report was successfully cr." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @report.update(report_params)
      respond_to do |format|
        format.html { redirect_to @report, notice: "Task was successfully upd." }
        format.turbo_stream { flash.now[:notice] = "Report was successfully upd." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.report.destroy
    redirect_to @task
  end

  private

  def set_variable_report
    @report = @task.report
  end

  def set_report
    @task = Task.find(params[:task_id])
  end

  def report_params
    params.require(:report).permit(:title, :description)
  end
end
