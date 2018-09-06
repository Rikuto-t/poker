Rails.application.routes.draw do
  get 'home/top'
  get 'home/check'
  post 'home/check'

  root to: 'visitors#index'
end
