Rails.application.routes.draw do
  namespace "v1" do
    resources :questions
    resources :votes, only: :create
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      omniauth_callbacks: 'v1/auth/omniauth_callbacks'
    }
  end
end
