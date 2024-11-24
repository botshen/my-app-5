Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "posts#index"
  get "/users/:id", to: "users#show"
  post "/users/", to: "users#create"

  # 添加messages资源路由
  resources :messages do
    resources :comments # 嵌套路由，让评论从属于留言
  end
end
