class SprintController < ApplicationController

  def index
    @sprint = Sprint.find(params[:id])
 #   @done_sprints = Dashboard.find( params[:id]).sprints.where(finished: true)
  end


  def get_sprint_cards
    cards = SprintCard.where(sprint_board_id: params[:sprint_board_id])
    render json: cards
  end

  def end_sprint
    sprint = Sprint.find(params[:sprint_id])
    new_sprint = sprint.dashboard.sprints.create(active: true, finished:false, started:false)
    new_sprint.sprint_boards.build(title: "Sprint Backlog")
    new_sprint.sprint_boards.build(title: "Planning")
    new_sprint.sprint_boards.build(title: "In Work")
    new_sprint.sprint_boards.build(title: "Code Review")
    new_sprint.sprint_boards.build(title: "Done")
    new_sprint.save
    new_sprint.cards << sprint.cards.where(done: nil)
    sprint.update(finished: true, active:false)
  end
end
