Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  match "*a" => "application#notFound", via: :all

end
