class SprintCardController < ApplicationController

  def update
    sprint_card = SprintCard.find(params[:id])
    sprint_card.update(title: params[:title], color: params[:color])

    if params[:aufwand].to_i != 0
      estimation = sprint_card.estimation_rounds.last.estimated_works.find_by(user_id: params[:user_id])
      if estimation.nil?
        sprint_card.estimation_rounds.last.estimated_works.create(user_id: params[:user_id], user_name: params[:user_name], estimated_days: params[:aufwand])
      else
        estimation.update(estimated_days: params[:aufwand])
      end
    end

    sprint_card.estimation_rounds.last.work_comments.create(user_name: params[:user_name], text: params[:text]) unless params[:text].empty?
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

  def check_estimations
    sprint_card = SprintCard.find(params[:cardId])
    estimations = sprint_card.estimation_rounds.find(params[:roundId]).estimated_works

    if estimations.count == sprint_card.sprint_board.sprint.dashboard.project.users.count

      day = estimations.first.estimated_days
      equal_estimation = true

      estimations.each do |f|
         if day != f.estimated_days
           equal_estimation = false
         end
      end
      array = Array.new
      estimations.each do |f|
        array << f.as_json.merge({agreement: equal_estimation})
      end

      equal_estimation ? sprint_card.update(released: true, html_id: "draggable", work_to_do: day) : ""
      puts json: array
      render json: array
    else
    end

  end

  def check_comments
    sprint_card = SprintCard.find(params[:cardId])
    comments = sprint_card.estimation_rounds.find(params[:roundId]).work_comments

    render json: comments
  end

end
