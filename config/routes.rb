Rails.application.routes.draw do
  root 'home#top'
  get 'check' => 'home#check'
  post 'check' => 'home#check'

  get '*unmatched_route', to: 'application#render_404'


  root to: 'visitors#index'
end
