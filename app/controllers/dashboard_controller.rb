class DashboardController < ApplicationController

  def index
    @projects = Project.all
  end

  def new_project
    Project.create(name: params[:title])
  end
end
