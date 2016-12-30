class SprintCardController < ApplicationController

  def update
    sprint_card = SprintCard.find(params[:id])
    sprint_card.update(title: params[:title], color: params[:color])
    estimation = EstimatedWork.find_by(sprint_card_id: sprint_card.id, user_id: params[:user_id])
    if estimation.nil?
      sprint_card.estimated_works.create(user_id: params[:user_id], user_name: params[:user_name], estimated_days: params[:aufwand])
    else
      estimation.update(estimated_days: params[:aufwand])
    end
    card = Card.find_by(matching_sprint_card_id: sprint_card.id)
    card.update(title: params[:title], color: params[:color])

  end

  def done
    card = Card.find_by(matching_sprint_card_id: params[:cardId])
    SprintCard.find(params[:cardId]).update(sprint_board_id: params[:boardId])
    board = Board.find(card.board_id)
    board = board.dashboard.boards.find_by(title: "Fertig")
    card.update(board_id: board.id, html_id: "")
  end

  def estimate_work
    sprint_card = SprintCard.find(params[:id])
  end

  def check_estimations
    sprint_card = SprintCard.find(params[:cardId])
    estimations = sprint_card.estimated_works

    puts estimations.to_json

    render json: estimations
  end

end
