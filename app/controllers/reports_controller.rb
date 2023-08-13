class ReportsController < ApplicationController
  before_action :set_report, except: %i[index]
  before_action :set_variable_report, only: %i[show edit update]
  before_action :authenticate_user!

  def show
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new
    @report = @task.build_report(report_params)
    if @report.save
      redirect_to @task
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @report.update(report_params)
      redirect_to :@report
    else
      render :edit
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
