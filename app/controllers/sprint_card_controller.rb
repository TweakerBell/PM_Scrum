class SprintCardController < ApplicationController
  def update
    card = SprintCard.find(params[:id])
    card.update(title: params[:title], color: params[:color])
  end
end
