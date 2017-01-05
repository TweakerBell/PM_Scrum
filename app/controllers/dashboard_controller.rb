class DashboardController < ApplicationController

  def index
    @dashboard = Dashboard.find_by(project_id: params[:id])
  end

  def change_board
    card = Card.find(params[:cardId])
    card.update(board_id: params[:boardId])
  end

  def change_board_and_delete
    card = Card.find(params[:cardId])
    card.update(board_id: params[:boardId])
    sprint_card = SprintCard.find(card.matching_sprint_card_id)
    sprint_card.destroy
  end

  def get_cards
    cards = Card.where(board_id: params[:board_id])
    render json: cards
  end

end
