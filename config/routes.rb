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
      resource :permits, only: [:create, :destroy]
      resources :club_comments, only:[:create, :destroy]
      collection do
        get :accept
      end 
      member do 
        get :club_works
        get :member
        get :permit
        get :leave
      end 
    end 
    
    resources :reports, only: [:create] do
      collection do
        post :confirm
        get :accepted
      end
    end
      
    resources :works do
      resource :favorites, only:[:create, :destroy]
      resources :work_comments, only:[:create, :destroy]
      member do 
        get 'report' => "reports#new", as:"report"
      end
      collection do
        post :download
      end
    end
    
    resources :users, only: [:edit, :update] do
      resource :relationship, only: [:create, :destroy]
      member do
        get 'my_page' => "users#show", as:"my_page"
        get 'following' => "relationships#following", as:"following"
        get 'followers' => "relationships#followers", as:"followers"
        get :confirm
        patch :unsubscribe
      end
      collection do
      end
    end
    
    get "search" => "searches#search"
    
  end 
  
  
  namespace :admin do
    
    resources :clubs, only: [:index, :show] do
      member do
        get :member
      end
    end
    
    resources :works, only: [:index, :show, :update] do
      collection do
        post :confirm
      end
    end
    
    resources :users, only: [:index, :show, :update] do
      member do
        get :confirm
      end 
    end 
    
    resources :reports, only: [:index, :show, :update]
    
    get "search" => "searches#search"
    
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
