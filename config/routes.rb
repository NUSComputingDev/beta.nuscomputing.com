Rails.application.routes.draw do

  # mc devise
  devise_for :members
  devise_scope :member do
    delete 'mc/logout', to: 'members/sessions#destroy', as: :destroy_member_session
  end

  # mc links
  constraints subdomain: 'mc' do
    get '/auth/google_oauth2/callback', to: 'authentications#google_oauth2'

    root 'mc/base#home', as: 'mc_root'
    get '/login', to: 'mc/base#login', as: 'mc_login'

    authenticate :member do
      scope module: 'mc', as: 'mc' do
        resources :articles

        get 'enquiries', to: 'enquiries#index', as: 'enquiries'

        namespace :blast do
          get '/', to: "/mc/blast#home"
          resources :blast_requests
          resources :blast_emails
        end

        namespace :locker do
          get '/', to: "/mc/locker#home"
          resources :locker_rounds, :locker_allocations, :lockers, :locker_ballots
          post '/allocate/:id/', to: "/mc/locker/locker_rounds#allocate", as: "allocate"
          post '/', to: "/mc/locker#email", as: "email"
        end

        namespace :borrow do
          get '/', to: "/mc/borrow#home"
          get 'reload'
          resources :items, :item_types
          resources :item_transactions do
            member do
              patch 'complete'
            end
          end
          resources :item_requests do
            member do
              patch 'approve'
              patch 'reject'
              patch 'reset'
            end
          end
        end

        mount Resque::Server, at: 'resque', as: 'resque'

        # disable wiki for now since i don't know how it works
        # get '/wiki/mc/login' => redirect("/")
        # mount App, at: 'wiki'
        get '/wiki', to: redirect('/'), as: 'app'
      end
    end
  end

  # portal devise
  devise_for :users
  devise_scope :user do
    delete '/logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  # CK editor for crafting blog posts
  mount Ckeditor::Engine => '/ckeditor'

  # portal links
  constraints subdomain: 'portal' do

    get '/auth/ivle/callback', to: 'authentications#ivle'

    root 'portal/base#home', as: 'portal_root'
    get '/login', to: 'portal/base#login', as: 'portal_login'

    authenticate :user do
      scope module: 'portal', as: 'portal' do
        get '/profile', to: 'profile#show', as: 'profile'
        #get '/locker', to: 'locker#home', as: 'locker'

        namespace :locker do
          get '/', to: '/portal/locker#home'
          resources :locker_ballots, only: [:index, :create, :update, :destroy]
        end

        # remove the borrow system for now, don't know how it works
        # resources :item_types, only: [:index, :show], path: "borrow"
        # resources :items, only: [:index, :show]
        # resources :item_requests, only: [:create]
      end
    end
  end

  # main links
  constraints subdomain: '' do
    root 'pages#home', as: 'main_root'

    get '/', to: 'pages#home', as: 'home'
    get '/about', to: 'pages#about', as: 'about'
    get '/events', to: 'pages#events', as: 'events'
    get '/students', to: 'pages#students', as: 'students'
    get '/connect', to: 'pages#connect', as: 'connect'
    get '/sponsors', to: 'pages#sponsors', as: 'sponsors'

    # templates for popups
    get 'templates/events'
    get 'templates/events/:link', to: 'templates#events'
    get 'templates/about'
    get 'templates/about/:name', to: 'templates#about'

    # links to popup content
    get '/about/:name', to: 'pages#mcmem', as: 'mcmem'
    get '/events/:link', to: 'pages#event', as: 'event'

    # for receiving enquiry form
    post '/connect', to: 'pages#enquiry', as: 'enquiry'
  end

  # main root
  root 'pages#home'

	#resources :feedbacks, only: [:create, :new]
	#resources :articles, only: [:index, :show]


end
