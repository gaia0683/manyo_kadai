class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all.order(created_at: 'DESC')
    if params[:sort_expired]
      @tasks = Task.all.order(end_time: 'DESC')
    end
    if params[:task].present?
      if task_params[:name].present? && task_params[:status].present?
        @tasks = Task.search(task_params[:name],task_params[:status])
      elsif task_params[:name].present?
        @tasks = Task.search_name(task_params[:name])
      elsif task_params[:status].present?
        @tasks = Task.search_status(task_params[:status])
    else
      end
    end
  end


  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task.id), notice: "タスクを登録しました！"
    else
      render :new
    end
  end


  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end


  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content,:end_time,:status)
  end
end
