class DashboardController < ApplicationController

  def index
    @dashboard = Dashboard.find_by(project_id: params[:id])
    to_do = SprintCard.sum(:work_to_do)
    done = SprintCard.sum(:work_done)
    left = to_do - done
    @ready = {left: left, done: done}
    @done_sprints = @dashboard.sprints.where(active:false)
    @current_sprint = @dashboard.sprints.find_by(active:true)
    array = @dashboard.sprints.pluck(:id)
    @archiv = Card.where(sprint_id: array).where(done: true)
  end

  def change_board
    card = Card.find(params[:cardId])
    card.update(board_id: params[:boardId])
  end

  def change_board_and_delete
    card = Card.find(params[:cardId])
    card.update(board_id: params[:boardId], sprint_id: nil)
    card.sprint_cards.each do |sprint_card|
      sprint_card.destroy
    end
  end

  def get_cards
    cards = Card.where("board_id = #{params[:board_id]} and (sprint_id is null or sprint_id = #{params[:sprint_id]})").order(:position)
    render json: cards.to_json(include: :acceptance_criteriums)
  end

  def render_charts
    @dashboard = Dashboard.find_by(project_id: params[:id])
    to_do = SprintCard.sum(:work_to_do)
    done = SprintCard.sum(:work_done)
    left = to_do - done
    @ready = {left: left, done: done}
    sprint = @dashboard.sprints.find_by(active: true)
    @first = Statistic.where(sprint_id: sprint.id).group_by_day(:created_at).sum(:work_total)
    @second = Statistic.where(sprint_id: sprint.id).group_by_day(:created_at).sum(:work_done)
    @third = Statistic.where(sprint_id: sprint.id).group_by_day(:created_at).sum(:work_left)
    @fourth = SprintCard.where(sprint_id: sprint.id).where.not(username: "null").group(:username).sum(:work_done)
    @six = SprintCard.where(sprint_id: sprint.id).where.not(username: "null").group(:username).sum(:work_to_do)
    @seven = SprintCard.where(sprint_id: sprint.id).where.not(username:  "null").group(:username).count
    @orig = Statistic.where(sprint_id: sprint.id).group_by_day(:created_at).sum(:work_left)
    render partial: 'charts'
  end

  def render_sb
    dashboard = Dashboard.find_by(project_id: params[:id])
    @data = Statistic.where(sprint_id: dashboard.sprints.find_by(active: true).id).group_by_day(:created_at).sum(:work_left)
    render partial: 'sprint_burndown'
  end

  def render_participants
    @dashboard = Dashboard.find(params[:id])
    @users = @dashboard.project.users
    @available_users = User.all - @users
    roadmap_rows = @dashboard.roadmap_rows
    render partial: 'participant', locals: {roadmap_rows: roadmap_rows, dashboard_id: params[:id]}
  end
  def remove_user
    user = User.find(params[:user_id])
    project = Project.find(params[:project_id])
    project.users.delete(user)
  end
end
