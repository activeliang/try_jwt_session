Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/login' => 'login#create'
  post '/refresh' => 'refresh#create'
  resources :posts
end
