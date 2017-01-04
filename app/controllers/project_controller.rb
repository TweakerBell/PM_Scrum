class ProjectController < ApplicationController

  def welcome
  end
  def index
  end
  def add_user
    project = Project.find(params[:projectId])
    user = User.find(params[:userId])
    project.users << user
  end
  def get_users
    project = Project.find(params[:project_id])
    render json: project.users
  end
  def get_available_users
    project = Project.find(params[:project_id])
    users = User.all - project.users
    render json: users
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
    current_user.projects << project
  end

  def get_projects
    projects = current_user.projects
    render json: projects
  end

  def destroy_project
    project = Project.find(params[:projectId])
    project.destroy
    render 'project/welcome'
  end

  def user_count
    render json: {user_count: Project.find(params[:project_id]).users.count}
  end

end
