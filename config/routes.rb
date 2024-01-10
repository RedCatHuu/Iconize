Rails.application.routes.draw do
  
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    
    root to: "homes#top"
    get 'homes/about'
    
    resources :clubs do
      get "invite" => "groups#invite"
      get "leave" => "groups#leave"
      collection do
        get :myclub
      end 
    end 
    
    resources :reports, only: [:create] do
      collection do
        post :confirm
        get :accepted
      end
    end
      
    resources :works do
      member do 
        get 'report' => "reports#new", as:"report"
      end
      collection do
        get :bookmarks
        post :download
      end
    end
    
    resources :users, only: [ :edit, :update] do
      resource :relationship, only: [:create, :destroy]
      member do
        get 'my_page' => "users#show", as:"my_page"
        get 'following' => "relationships#following", as:"following"
        get 'followers' => "relationships#followers", as:"followers"
      end
      collection do
        post :confirm
        patch :unsubscribe
      end
    end
    
    get "search" => "searches#search"
    
  end 
  
  
  namespace :admin do
    
    resources :works, only: [:index, :show, :update] do
      collection do
        post :confirm
      end
    end
    
    resources :users, only: [:index, :show, :update] do
      collection do
        post :confirm
      end 
    end 
    
    resources :reports, only: [:index, :show, :update]
    
    get "search" => "searches#search"
    
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
