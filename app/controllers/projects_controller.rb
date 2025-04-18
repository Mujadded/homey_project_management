class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [ :show, :edit, :update, :destroy, :update_status ]
  before_action :authorize_admin_or_pm!, only: [ :update_status ]

  def index
    @projects = Project.all
  end

  def show
    @pagy, @project_events = pagy(@project.project_events.includes(:user), items: 10)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted."
  end

  def update_status
    previous_status = @project.status
    new_status = params[:status]

    if Project::STATUSES.include?(new_status) && @project.update(status: new_status)
      # Create a status change event
      @project.project_events.create!(
        user: current_user,
        event_type: "status_change",
        previous_status: previous_status,
        new_status: new_status
      )

      redirect_to @project, notice: "Project status was successfully updated."
    else
      redirect_to @project, alert: "Failed to update project status."
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :status)
  end

  def authorize_admin_or_pm!
    unless current_user.admin? || current_user.pm?
      redirect_to @project, alert: "You are not authorized to perform this action."
    end
  end
end
