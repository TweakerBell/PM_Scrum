class RoadmapController < ApplicationController
  def render_roadmap
    dashboard = Dashboard.find(params[:id])
    roadmap_rows = dashboard.roadmap_rows
    render partial: 'dashboard/roadmap', locals: {roadmap_rows: roadmap_rows, dashboard_id: params[:id]}
  end

  def add_row
    dashboard = Dashboard.find(params[:id])
    last_roadmap = dashboard.roadmap_rows.where.not(sprint_nr: nil).last
    if last_roadmap.nil?
      params[:milestone] == 'true' ?
          dashboard.roadmap_rows.create(is_milestone: true, title: params[:title]) :
          dashboard.roadmap_rows.create(sprint_nr: 1, is_milestone: false)
    else
      new_nr = last_roadmap.sprint_nr.to_i
      new_nr += 1
      params[:milestone] == 'true' ?
          dashboard.roadmap_rows.create(is_milestone: true, title: params[:title]) :
          dashboard.roadmap_rows.create(sprint_nr: new_nr, is_milestone: false)
    end
  end

  def add_roadmap_item
    row = RoadmapRow.find(params[:row_id])
    row.roadmap_items.create(title: params[:title], is_user_story: params[:is_story] , is_feature: params[:is_feature])
  end

  def delete_roadmap_item
    item = RoadmapItem.find(params[:id])
    item.destroy
  end
  def delete_roadmap_row
    row = RoadmapRow.find(params[:id])
    row.destroy
  end
end
