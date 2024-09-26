Rails.application.routes.draw do
  get 'projects/index'
  get 'projects/show'
  get 'projects/new'
  get 'projects/create'
  get 'projects/edit'
  get 'projects/update'
  get 'projects/destroy'
  devise_for :users

  # Define a root route for when users log in
  authenticated :user do
    root 'projects#index', as: :authenticated_root
  end

  root to: redirect('/users/sign_in') # Redirects non-logged-in users to the login page

  resources :projects
end
