Rails.application.routes.draw do
  get "/" => "home#top"
  get "about" => "home#about"


  get "posts/index" => "posts#index"
  get "posts/new"  => "posts#new"
  post "posts/create" =>"posts#create"
  get "posts/:id/show" => "posts#show"

end
