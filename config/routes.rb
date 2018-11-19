Rails.application.routes.draw do

  resources :agent, :controller => 'agent', :as => 'agents'

  resources :creator, :controller => 'creator', :as => 'creators'

  resources  :object_resource, :controller => 'object_resource', :as => 'object_resources'

  resources  :collection, :controller => 'collection', :as => 'collections'

  root to: redirect('object_resource/new')
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
