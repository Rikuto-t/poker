Rails.application.routes.draw do
  root 'home#top'
  get 'check' => 'home#check'
  post 'check' => 'home#check'

  root to: 'visitors#index'
end
