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

  def delete_sprint_card
    sprint_card = SprintCard.find(params[:card_id])
    sprint_card.destroy
  end

  def done
    sprint_card = SprintCard.find(params[:cardId])
    sprint = sprint_card.sprint_board.sprint
    sprint_board = sprint.sprint_boards.find_by(title: 'Done')
    sprint_card.update(sprint_board_id: sprint_board.id, html_id: '', label: 'done', done: true)

    left_sprint_cards = sprint_card.card.sprint_cards.where(done: false).last
    if left_sprint_cards.nil?
      sprint_card.card.update(done: true)
      dashboard_id = sprint.dashboard.id

      today = Statistic.where(dashboard_id: dashboard_id, created_at: DateTime.now.midnight..DateTime.now.end_of_day).first
      last_stat = Statistic.where(dashboard_id: dashboard_id).last
      if today.nil?
        Statistic.create(dashboard_id: dashboard_id, work_total: last_stat.work_total.to_i,
                         work_left: last_stat.work_left.to_i-sprint_card.card.work_to_do.to_i)
      else
        today.update(work_left: last_stat.work_left.to_i-sprint_card.card.work_to_do.to_i)
      end
    end
    all_card_count = 0
    sprint_card.sprint_board.sprint.sprint_boards.each do |f|
      all_card_count += f.sprint_cards.count
    end

    done_card_count = 0
    sprint_card.sprint_board.sprint.sprint_boards.each do |f|
      done_card_count += f.sprint_cards.where(label: 'done').count
    end

    if all_card_count == done_card_count
      sprint.update(finished: true, active:false)
      new_sprint = sprint.dashboard.sprints.create(active: true, finished:false, started:false)
      new_sprint.sprint_boards.build(title: "Sprint Backlog")
      new_sprint.sprint_boards.build(title: "Planning")
      new_sprint.sprint_boards.build(title: "In Work")
      new_sprint.sprint_boards.build(title: "Code Review")
      new_sprint.sprint_boards.build(title: "Done")
      new_sprint.save
    end

  end

  def update_prio

    n = params[:ind].length
    n.times do |f|
      Card.find(params[:ids][f]).update(position: params[:ind][f])
    end

  end

  def update_retro
    sprint = Sprint.find(params[:sprint_id])
    if params[:text] != ''
      sprint.sprint_retro_comments.create(text: params[:text], username: current_user.username,
                                          sprint_id: sprint.id, pro: params[:pro])
    end

    if params[:pro] == "true"
      comments = sprint.sprint_retro_comments.where(pro: true)
    else
      comments = sprint.sprint_retro_comments.where(pro: false)
    end
    puts comments.to_json
    render json: comments
  end

  def change_board
    sprint_card = SprintCard.find(params[:cardId])
    sprint_board = sprint_card.sprint_board.sprint.sprint_boards.find_by(title: params[:board_title])
    sprint_card.update(sprint_board_id: sprint_board.id)
  end

  def check_estimations
    sprint_card = SprintCard.find(params[:cardId])
    estimations = sprint_card.estimation_rounds.find_by(round_number: params[:round_number]).estimated_works

    if estimations.count == sprint_card.sprint_board.sprint.dashboard.project.users.where( role: "scrum_team").count

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
    asset = sprint_card.to_json(include: [:change_requests, estimation_rounds: {include: [:work_comments, :estimated_works] }, order: :id ])
    render json: asset
  end

  def update_comments
    round = EstimationRound.find(params[:round_id])
    round.work_comments.create(user_name: params[:username], text: params[:text]) unless params[:text].nil? || params[:text].empty?

    render json: round.work_comments
  end

  def update_request
    sprint_card = SprintCard.find(params[:card_id])
    sprint_card.change_requests.create(username: current_user.username, text: params[:text]) unless params[:text].nil? || params[:text].empty?

    render json: sprint_card.change_requests
  end

  def estimate
    sprint_card = SprintCard.find(params[:card_id])
    round = EstimationRound.find(params[:round_id])
    estimation = round.estimated_works.find_by(user_id: current_user.id)
    estimation.nil? ? round.estimated_works.create(user_id: current_user.id, user_name: current_user.username, estimated_days: params[:aufwand]) : ""
    user_count = sprint_card.sprint_board.sprint.dashboard.project.users.where(role: "scrum_team").count

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
        sprint_card.update(released: true, work_to_do: day)
      end
      sprint = sprint_card.sprint_board.sprint
      all_cards = SprintCard.where(sprint_id: sprint.id )

      if all_cards.count == SprintCard.where(sprint_id: sprint.id).where.not(work_to_do: "null").count
        Statistic.create(sprint_id: sprint.id, work_total: all_cards.sum(:work_to_do), work_left: all_cards.sum(:work_to_do), work_done: all_cards.sum(:work_done))
        sprint.update(active: true)
      end

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
    prio = params[:priority]
    prio != '' ? sprint_card.update(color: params[:color], title: params[:title], priority: prio) :
        sprint_card.update(color: params[:color], title: params[:title])

  end

  def update_work_done
    sprint_card = SprintCard.find(params[:card_id])
    sprint_card.update(work_done: params[:work_done])
    sprint = sprint_card.sprint_board.sprint
    all_cards = SprintCard.where(sprint_id: sprint.id )
    today = Statistic.where(sprint_id: sprint.id, created_at: DateTime.now.midnight..DateTime.now.end_of_day).first
    if today.nil?
      Statistic.create(sprint_id: sprint.id, work_total: all_cards.sum(:work_to_do),
                       work_left: (all_cards.sum(:work_to_do) - all_cards.sum(:work_done)),
                       work_done: all_cards.sum(:work_done))
    else
      today.update(work_total: all_cards.sum(:work_to_do),
                   work_left: (all_cards.sum(:work_to_do) - all_cards.sum(:work_done)),
                   work_done: all_cards.sum(:work_done))
    end

  end

  def register_for_card
    sprint_card = SprintCard.find(params[:card_id])
    next_board_id = sprint_card.sprint_board.sprint.sprint_boards.find_by(title: 'In Work').id
    sprint_card.update(username: current_user.username, user_id: current_user.id, sprint_board_id: next_board_id, released: true, html_id: "draggable")
  end

  def move_to_planned
    sprint_card = SprintCard.find(params[:card_id])
    planned_id = sprint_card.sprint_board.sprint.sprint_boards.find_by(title: 'Planned').id
    sprint_card.update(sprint_board_id: planned_id)
  end

  def new_sprint_card
    card = Card.find(params[:card_id])
    sprint = Sprint.find(params[:sprint_id])
    sprint_board = sprint.sprint_boards.second
    sprint_card = SprintCard.create(title: params[:title], card_id: card.id, sprint_board_id: sprint_board.id, color: params[:color],
                                    work_done: 0, released: false, priority: params[:priority], sprint_id: sprint.id)
    sprint_card.estimation_rounds.create(active: true, round_number: 1)
  end

end
