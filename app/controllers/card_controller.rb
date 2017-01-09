class CardController < ApplicationController

  def new_card
    board = Board.find(params[:board_id])
    prio = board.cards.last.priority rescue nil
    if prio.nil?
      card = board.cards.create(title: params[:title], board_id: board.id, color: "lightcoral", html_id: "", priority: 1)
    else
      card = board.cards.create(title: params[:title], board_id: board.id, color: "lightcoral", html_id: "", priority: prio+1)
    end
    card.estimation_rounds.create(active: true, round_number: 1)
  end

  def move_to_sprint
    card = Card.find(params[:cardId])
    sprint = card.board.dashboard.sprints.find_by(active: true)
    if sprint.nil?
      sprint = card.board.dashboard.sprints.create(active:true, started: false, finished: false)
    else
      if card.board_id == params[:boardId].to_i
      else
        card.update(board_id: params[:boardId], sprint_id: sprint.id, html_id: "draggable")
      end
    end
  end

  def update
    card = Card.find(params[:id])
    sprint_card = SprintCard.find_by(matching_card_id: card.id)
    card.update(title: params[:title], color: params[:color])
    sprint_card.update(title: params[:title], color: params[:color]) unless sprint_card.nil?
  end

  def assets
    card = Card.find(params[:card_id])
    asset = card.to_json(include: {estimation_rounds: {include: [:work_comments, :estimated_works] }})
    puts asset
    render json: asset
  end

  def update_card_options
    card = Card.find(params[:card_id])
    prio = params[:priority]
    prio != '' ? card.update(color: params[:color], title: params[:title], priority: prio) :
        card.update(color: params[:color], title: params[:title])

  end
end
