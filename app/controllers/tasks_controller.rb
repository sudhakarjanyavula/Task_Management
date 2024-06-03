# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
    skip_before_action :verify_authenticity_token
    # before_action :authorize_request
    before_action :set_task, only: [:show, :update, :destroy]
  
    def new
    end
    def create
        # @current_user = User.first
        @task = @current_user.tasks.new(task_params)
      if @task.save
        render json: @task, status: :created
      else
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @task.update(task_params)
        render json: @task
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end
  
    def index
        @user = User.find(params[:user_id])
        list_type = params[:list_type] || 'backlog'
        @tasks = case list_type
                 when 'backlog'
                   @user&.tasks&.where(status: 'Backlog')
                 when 'in_progress'
                   @user&.tasks&.where(status: 'In Progress')
                 when 'done'
                   @user&.tasks&.where(status: 'Done')
                 else
                   @user&.tasks
                 end
        respond_to do |format|
          format.html
          format.js { render partial: 'shared/task_table.html.erb', locals: { tasks: @tasks } }
        end
    end
      
    def destroy
      @task.destroy
      render json: { message: 'Task deleted successfully' }
    end
  
    private
  
    def set_task
      @task = @current_user.tasks.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Task not found' }, status: :not_found
    end
  
    def task_params
      params.require(:task).permit(:title, :description, :due_date, :status)
    end
  end
  