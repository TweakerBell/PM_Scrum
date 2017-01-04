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
    estimations = sprint_card.estimation_rounds.find_by(round_number: params[:round_number]).estimated_works

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
      render json: array
    else
    end

  end

  def check_comments
    sprint_card = SprintCard.find(params[:cardId])
    comments = sprint_card.estimation_rounds.find_by(round_number: params[:round_number]).work_comments

    render json: comments
  end

  def add_round
    sprint_card = SprintCard.find(params[:card_id])
    round = sprint_card.estimation_rounds.find_by(round_number: params[:round_number].to_i+1)
    round_created = false
    if round.nil?
      sprint_card.estimation_rounds.create(active: true, round_number: params[:round_number].to_i+1)
      sprint_card.estimation_rounds.find_by(round_number: params[:round_number]).update(active: false)
      round_created = true
    else
      sprint_card.estimation_rounds.find_by(round_number: params[:round_number]).update(active: false)
    end
    render json: {round_created: round_created}
  end

  def card_assets
    sprint_card = SprintCard.find(params[:card_id])
    asset = sprint_card.to_json(include: { estimation_rounds: {include: [:work_comments, :estimated_works] }})
    puts asset
    render json: asset
  end

  def update_comments
    round = EstimationRound.find(params[:round_id])
    round.work_comments.create(user_name: params[:username], text: params[:text]) unless params[:text].nil? || params[:text].empty?

    render json: round.work_comments
  end

  def estimate
    sprint_card = SprintCard.find(params[:card_id])
    round = EstimationRound.find(params[:round_id])
    estimation = round.estimated_works.find_by(user_id: current_user.id)
    estimation.nil? ? round.estimated_works.create(user_id: current_user.id, user_name: current_user.username, estimated_days: params[:aufwand]) : ""
    user_count = sprint_card.sprint_board.sprint.dashboard.project.users.count

    if user_count == round.estimated_works.count

      estimations = round.estimated_works
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
      render json: array
    end
  end

  def check_estimation_done
    round = EstimationRound.find(params[:round_id])
    estimation = round.estimated_works.find_by(user_id: current_user.id)
    has_voted = false
    estimation.nil? ? "" : has_voted = true

    estimations = round.estimated_works
    if estimations.first.nil?
      render json: {has_voted: has_voted, voting_done: false}
    else
      day = estimations.first.estimated_days
      equal_estimation = true

      estimations.each do |f|
        if day != f.estimated_days
          equal_estimation = false
        end
      end

      render json: {has_voted: has_voted, voting_done: equal_estimation}
    end
  end

  def update_options
    sprint_card = SprintCard.find(params[:card_id])
    sprint_card.update(color: params[:color], title: params[:title])
  end

end
