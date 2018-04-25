Rails.application.routes.draw do
  get "/" => "home#top"
  get "about" => "home#about"


  get "posts/index" => "posts#index"
  get  "posts/new"  => "posts#new"
  post "posts/create" =>"posts#create"
  get "posts/:id" => "posts#show"


  get "users/index" => "users#index"
  get "users/:id" => "users#show"
  get "signup" => "users#new"
  post "users/create" => "users#create"
  get  "login" => "users#login_form"
  post "login" => "users#login"

end
