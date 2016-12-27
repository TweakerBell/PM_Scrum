class DashboardController < ApplicationController

  def index
    @dashboard = Dashboard.find_by(project_id: params[:id])
  end

  def change_board
    card = Card.find(params[:cardId])
    card.update(board_id: params[:boardId])
  end
end
