class CardController < ApplicationController

  def new_card
    board = Board.find(params[:board_id])
    board.cards.build(title: params[:title], board_id: board.id, color: "lightcoral")
    board.save
  end

  def move_to_sprint
    card = Card.find(params[:cardId])

    if card.board_id == params[:boardId].to_i
    else
      card.update(board_id: params[:boardId])
      dashboard = Dashboard.find(card.board.dashboard.id)
      SprintCard.create(title: card.title, priority: 1, visible: true, sprint_board_id: dashboard.sprint.sprint_boards.first.id,
                        color: "lightcoral", released: false)
    end
  end

  def rename
    card = Card.find(params[:id])
    card.update(title: params[:title])
  end

  def update
    card = Card.find(params[:id])
    card.update(title: params[:title], color: params[:color])
  end
end
