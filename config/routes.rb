CafeTownsendSpineRails::Application.routes.draw do

  root :to => "sessions#create"

  resources :sessions
  resources :employees


end
