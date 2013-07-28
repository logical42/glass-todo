GlassTodo::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  post 'glass/notifications', to: 'glass/notifications#callback', as: 'glass_notifications_callback'
  get "pingurl", to: 'pages#pingurl'
  root to: 'pages#home'
end
