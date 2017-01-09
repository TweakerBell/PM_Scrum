class SprintController < ApplicationController

  def index
    @sprint = Sprint.find(params[:id])
 #   @done_sprints = Dashboard.find( params[:id]).sprints.where(finished: true)
  end


  def get_sprint_cards
    cards = SprintCard.where(sprint_board_id: params[:sprint_board_id])
    render json: cards
  end
end
