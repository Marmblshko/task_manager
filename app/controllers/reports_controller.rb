class ReportsController < ApplicationController
  before_action :set_task, only: %i[new create edit update destroy]
  before_action :set_report, only: %i[edit update destroy]

  def new
    @report = @task.reports.build
  end

  def edit
  end

  def create
    @report = @task.reports.create(report_params)
    @report.creator_username = current_user.username
    @report.creator_id = current_user.id
    if @report.save
      respond_to do |format|
        format.html { redirect_to @task, notice: 'Report was successfully created.' }
        format.turbo_stream { flash.now[:notice] = 'Report was successfully created.' }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      respond_to do |format|
        format.html { redirect_to @task, notice: 'Report was successfully updated.' }
        format.turbo_stream { flash.now[:notice] = 'Report was successfully updated.' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to @task, notice: 'Report was successfully destroyed.' }
      format.turbo_stream { flash.now[:notice] = 'Report was successfully destroyed.' }
    end
  end

  private

  def set_report
    @report = @task.reports.find(params[:id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def report_params
    params.require(:report).permit(:title, :description)
  end
end
