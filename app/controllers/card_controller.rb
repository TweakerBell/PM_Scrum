class CardController < ApplicationController

  def new_card
    board = Board.find(params[:board_id])
    board.cards.build(title: params[:title], board_id: board.id)
    board.save
  end

  def move_to_sprint
    card = Card.find(params[:card_id])
    board_id = card.board.dashboard.boards.second.id
    card.update(board_id: board_id)

    dashboard = Dashboard.find(params[:dashboard_id])

    SprintCard.create(title: card.title, priority: 1, visible: true, sprint_board_id: dashboard.sprint.sprint_boards.first.id )
  end

  def rename
    card = Card.find(params[:card_id])
    card.update(title: params[:title])
  end
end
