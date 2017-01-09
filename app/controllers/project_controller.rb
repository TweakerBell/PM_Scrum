class ProjectController < ApplicationController

  def welcome
  end
  def index
  end
  def role_management
    @users = User.all
  end
  def change_role
    user = User.find(params[:user_id])
    user.update(role: params[:role])
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
    project.dashboard.boards.build(title: "Product Backlog")
    project.dashboard.boards.build(title: "Aktueller Sprint")
    project.dashboard.sprints.build(active: true, started: false, finished: false)
    project.dashboard.sprints.last.sprint_boards.build(title: "Sprint Backlog")
    project.dashboard.sprints.last.sprint_boards.build(title: "Planned")
    project.dashboard.sprints.last.sprint_boards.build(title: "In Work")
    project.dashboard.sprints.last.sprint_boards.build(title: "Code Review")
    project.dashboard.sprints.last.sprint_boards.build(title: "Done")
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
    users = Project.find(params[:project_id]).users.where(role: "scrum_team").count
    render json: {user_count: users}
  end

end
