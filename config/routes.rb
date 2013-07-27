GlassTodo::Application.routes.draw do

  post 'glass/notifications', to: 'glass/notifications#callback', as: 'glass_notifications_callback'

  devise_for :users

  root to: 'pages#home'
end
