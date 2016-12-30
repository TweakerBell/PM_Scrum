class ProjectController < ApplicationController

  def index
    @projects = Project.all
  end

  def new_project
    project = Project.new(title: params[:title])

    project.build_dashboard
    project.dashboard.boards.build(title: "Project Backlog")
    project.dashboard.boards.build(title: "Sprint Backlog")
    project.dashboard.boards.build(title: "Fertig")
    project.dashboard.build_sprint
    project.dashboard.sprint.sprint_boards.build(title: "Sprint Backlog")
    project.dashboard.sprint.sprint_boards.build(title: "Dev")
    project.dashboard.sprint.sprint_boards.build(title: "Code Review")
    project.dashboard.sprint.sprint_boards.build(title: "Test")
    project.dashboard.sprint.sprint_boards.build(title: "Fertig")
    project.save
  end

  def get_projects
    projects = Project.all
    render json: projects
  end


end
