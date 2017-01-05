class SprintController < ApplicationController

  def index
    @sprint = Sprint.find_by(dashboard_id: params[:id])
  end

  def change_board
    sprint_card = SprintCard.find(params[:cardId])
    sprint_card.update(sprint_board_id: params[:boardId])
  end

  def get_sprint_cards
    cards = SprintCard.where(sprint_board_id: params[:sprint_board_id])
    render json: cards
  end
end
