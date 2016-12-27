Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'project#index'
  post '/new_project', to: 'project#new_project'
  get 'dashboard/:id', to: 'dashboard#index'
  post 'move_to_sprint', to: 'card#move_to_sprint'
  post '/new_card', to: 'card#new_card'
  post '/rename', to: 'card#rename'
  get 'sprint/:id', to: 'sprint#index'
  get '/change_sprint_board/:cardId/:boardId', to: 'sprint#change_board'
  get '/change_board/:cardId/:boardId', to: 'dashboard#change_board'
end
