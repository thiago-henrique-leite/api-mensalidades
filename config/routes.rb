Rails.application.routes.draw do
  namespace :api do
    resources :students
    resources :enrollments
    resources :bills, except: [:create]
  end
end
