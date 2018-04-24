Rails.application.routes.draw do
  get "/" => "home#top"
  get "about" => "home#about"


  get "posts/index" => "posts#index"
  get "posts/new"  => "posts#new"
  get "posts/:id/show" => "posts#show"

end
