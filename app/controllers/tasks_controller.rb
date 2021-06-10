# frozen_string_literal: true
class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks
      .search(search_by: params[:search_by], value: params[:query])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @task = find_task
  end

  def new
    @task = Task.new
  end

  def edit
    @task = find_task
  end

  def create
    @task = current_user.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to(@task, notice: "Task was successfully created.") }
        format.json { render(:show, status: :created, location: @task) }
      else
        format.html { render(:new, status: :unprocessable_entity) }
      end
    end
  end

  def update
    @task = find_task
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to(@task, notice: "Task was successfully updated.") }
        format.json { render(:show, status: :ok, location: @task) }
      else
        format.html { render(:edit, status: :unprocessable_entity) }
      end
    end
  end

  def destroy
    find_task.destroy!
    respond_to do |format|
      format.html { redirect_to(tasks_url, notice: "Task was successfully destroyed.") }
    end
  end

  private

  def find_task
    current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :status, :user_id)
  end
end
