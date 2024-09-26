Rails.application.routes.draw do
  devise_for :users

  # Define a root route for when users log in
  authenticated :user do
    root 'projects#index', as: :authenticated_root
  end

  root to: redirect('/users/sign_in') # Redirects non-logged-in users to the login page

  resources :projects do
    resources :project_comments, only: [:create]
  end

end
