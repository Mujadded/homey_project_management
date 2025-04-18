class ProjectEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def create
    @project_event = @project.project_events.new(
      user: current_user,
      event_type: "comment",
      content: project_event_params[:content]
    )

    if @project_event.save
      redirect_to @project, notice: "Comment was successfully added."
    else
      redirect_to @project, alert: "Failed to add comment."
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def project_event_params
    params.require(:project_event).permit(:content)
  end
end
