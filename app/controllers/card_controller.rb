class CardController < ApplicationController

  def new_card
    board = Board.find(params[:board_id])
    board.cards.build(title: params[:title], board_id: board.id, color: "lightcoral", html_id: params[:html_id])
    board.save
  end

  def move_to_sprint
    card = Card.find(params[:cardId])

    if card.board_id == params[:boardId].to_i
    else

      dashboard = Dashboard.find(card.board.dashboard.id)
      sprint_card = SprintCard.create(title: card.title, priority: 1, visible: true, sprint_board_id: dashboard.sprint.sprint_boards.first.id,
                                      color: card.color, released: false, matching_card_id: params[:cardId], html_id: "")
      sprint_card.estimation_rounds.create(active: true)
      card.update(board_id: params[:boardId], matching_sprint_card_id: sprint_card.id)

    end
  end

  def update
    card = Card.find(params[:id])
    sprint_card = SprintCard.find_by(matching_card_id: card.id)
    card.update(title: params[:title], color: params[:color])
    sprint_card.update(title: params[:title], color: params[:color]) unless sprint_card.nil?
  end
end
