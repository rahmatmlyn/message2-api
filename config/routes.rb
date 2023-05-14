Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post 'login', to: 'authentication#authenticate'
  get 'viewuser', to: 'users#index'
  post 'signup', to: 'users#create'
  get 'viewconversation', to: 'conversations#index'



  # dalam conversation hannya bisa melihat index/ isi conversationnya saja
  resources :conversations, only: [:index, :show]
  # dalam message hannya bisa melihat message dan membuat message
  resources :messages, only: [:index, :create]
end
