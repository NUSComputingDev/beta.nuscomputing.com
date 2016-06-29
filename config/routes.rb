Rails.application.routes.draw do

  # main page links
	get '/about', to: "pages#about", as: "about"
	get '/events', to: 'pages#events', as: 'events'
	get '/students', to: 'pages#students', as: 'students'
  get '/connect', to: "pages#connect", as: "connect"
	get '/sponsors', to: 'pages#sponsors', as: 'sponsors'

  # templates for popups
	get 'templates/events'
	get 'templates/events/:link', to: 'templates#events'
	get 'templates/about'
	get 'templates/about/:name', to: 'templates#about'

  # links to popup content
	get '/about/:name', to: 'pages#mcmem', as: 'mcmem'
	get '/events/:link', to: 'pages#event', as: 'event'

  # student-relevant links
  get '/profile', to: "profile#show", as: "profile", constraints: {subdomain: 'students'}
  get '/locker', to: "locker#home", as: "locker", constraints: {subdomain: 'students'}

  # for receiving enquiry form
	post '/connect', to: 'pages#enquiry', as: 'enquiry'

  devise_for :members, path: "mc"
	devise_for :users

  get "/auth/:action/callback", controller: "authentications", constraints: { action: /ivle|google_oauth2/ }

	devise_scope :user do
		delete '/logout', to: "devise/sessions#destroy", as: :destroy_user_session
	end

	devise_scope :member do
		delete 'mc/logout', to: "members/sessions#destroy", as: :destroy_member_session
	end

	authenticate :member do
		namespace :mc do
			resources :feedbacks, :articles 

			namespace :blast do
				get '/', to: "blast#home"
				resources :blast_requests
				resources :blast_emails
			end

			namespace :locker do
				get '/', to: "/mc/locker#home"
				resources :locker_rounds, :locker_allocations, :lockers, :locker_ballots
				post '/allocate', to: "/mc/locker#allocate", as: "allocate"
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
			get '/wiki/mc/login' => redirect("/mc")
			mount App, at: 'wiki'
			mount Resque::Server, at: "resque"
			root 'base#home'
		end
  end

	# page root
	root 'pages#home'

	mount Ckeditor::Engine => '/ckeditor'

	resources :feedbacks, only: [:create, :new]
	resources :articles, only: [:index, :show]
	resources :item_types, only: [:index, :show], path: "borrow"
	resources :items, only: [:index, :show]
	resources :item_requests, only: [:create]
	resources :locker_ballots, only: [:create, :update, :destroy]


end
