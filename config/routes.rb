Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'project#welcome'
  get '/start', to: 'project#index'
  post '/new_project', to: 'project#new_project'
  delete '/destroy_project/:projectId', to: 'project#destroy_project',as: 'destroy_project'
  get '/dashboard/:id', to: 'dashboard#index', as: 'dashboard'
  get '/move_to_sprint/:cardId/:boardId', to: 'card#move_to_sprint'
  post '/new_card', to: 'card#new_card'
  post '/add_user/:projectId/:userId', to: 'project#add_user'
  post '/rename/:id', to: 'card#rename'
  get 'sprint/:id', to: 'sprint#index'
  get '/change_sprint_board/:cardId/:boardId', to: 'sprint#change_board'
  get '/change_board/:cardId/:boardId', to: 'dashboard#change_board'
  post '/update_sprint_card/:id', to: 'sprint_card#update'
  post '/update_card/:id', to: 'card#update'
  get '/sprint_card_done/:cardId/:boardId', to: 'sprint_card#done'
  get '/check_estimations/:cardId', to: 'sprint_card#check_estimations'
  get '/get_projects', to: 'project#get_projects'
  get '/get_cards/:board_id', to: 'dashboard#get_cards'
  get '/get_users/:project_id', to: 'project#get_users'
  get '/get_available_users/:project_id', to: 'project#get_available_users'
end
