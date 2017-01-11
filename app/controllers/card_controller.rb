class CardController < ApplicationController

  def new_card
    board = Board.find(params[:board_id])
    position = board.cards.last.position rescue nil
    if position.nil?
      card = board.cards.create(title: params[:title], board_id: board.id, color: "lightcoral", html_id: "", position: 1,
                                is_user_story: params[:checked], priority: params[:priority], work_to_do: 0)
    else
      card = board.cards.create(title: params[:title], board_id: board.id, color: "lightcoral", html_id: "", position: position+1,
                                is_user_story: params[:checked], priority: params[:priority], work_to_do: 0)
    end
    card.estimation_rounds.create(active: true, round_number: 1)

    params[:criteria].each do |f|
      if f != ""
        card.acceptance_criteriums.create(text: f)
      end
    end
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
    asset = card.to_json(include: [:acceptance_criteriums, estimation_rounds: {include: [:work_comments, :estimated_works] }])
    puts asset
    render json: asset
  end

  def update_card_comments
    round = EstimationRound.find(params[:round_id])
    round.work_comments.create(user_name: params[:username], text: params[:text]) unless params[:text].nil? || params[:text].empty?

    render json: round.work_comments
  end

  def add_card_round
    card = Card.find(params[:card_id])
    round = card.estimation_rounds.find_by(round_number: params[:round_number].to_i+1)
    round_created = false
    if round.nil?
      card.estimation_rounds.create(active: true, round_number: params[:round_number].to_i+1)
      card.estimation_rounds.find_by(round_number: params[:round_number]).update(active: false)
      round_created = true
    else
      card.estimation_rounds.find_by(round_number: params[:round_number]).update(active: false)
    end
    render json: {round_created: round_created}
  end

  def update_card_options
    card = Card.find(params[:card_id])
    priority = params[:priority]
    priority != '' ? card.update(color: params[:color], title: params[:title], priority: priority) :
        card.update(color: params[:color], title: params[:title])

    n = params[:criteria_ids].length
    n.times do |i|
      id = params[:criteria_ids][i].to_i
      text = params[:criteria][i]
      if id == 0
        card.acceptance_criteriums.create(text: text) unless text == ''
      else
        crit = AcceptanceCriterium.find(id)
        if text != ""
          crit.update(text: text)
        else
          crit.destroy
        end
      end
    end
  end

  def delete_card
    card = Card.find(params[:card_id])
    card.destroy
  end

  def estimate
    card = Card.find(params[:card_id])
    round = EstimationRound.find(params[:round_id])
    dashboard = card.board.dashboard
    estimation = round.estimated_works.find_by(user_id: current_user.id)
    estimation.nil? ? round.estimated_works.create(user_id: current_user.id, user_name: current_user.username, estimated_days: params[:aufwand]) : ""
    user_count = dashboard.project.users.where( role: "scrum_team").count

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

      if equal_estimation
        card.update(work_to_do: day)
      else
        old_round = card.estimation_rounds.where(active: true).first
        old_round.update(active: false)
        card.estimation_rounds.create(round_number: (old_round.round_number+1), active: true)
      end



      today = Statistic.where(dashboard_id: dashboard.id, created_at: DateTime.now.midnight..DateTime.now.end_of_day).first
      if today.nil?
        last = Statistic.where(dashboard_id: dashboard.id).last
        if last.nil?
          Statistic.create(dashboard_id: dashboard.id, work_total: params[:aufwand].to_i, work_left: params[:aufwand].to_i) unless !equal_estimation
        else
          Statistic.create(dashboard_id: dashboard.id, work_total: (last.work_total+params[:aufwand].to_i),
          work_left: last.work_left+params[:aufwand].to_i) unless !equal_estimation
        end
      else
        today.update(work_total: today.work_total+params[:aufwand].to_i, work_left: today.work_left+params[:aufwand].to_i) unless !equal_estimation
      end

      render json: array
    end
  end

end
