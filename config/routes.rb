Rails.application.routes.draw do
  root "home#index"

  get "chat", to: "chat#index"
  post "/chat/ask", to: "chat#ask"
end