Rails.application.routes.draw do
  root 'home#top'
  get 'check' => 'home#check'
  post 'check' => 'home#check'

  mount API::Root => '/'

  get '*unmatched_route' => 'application#render_404'


  root to: 'visitors#index'
end
