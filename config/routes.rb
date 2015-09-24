Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

	resources :feedbacks, only: [:create, :new]
	resources :articles, only: [:index, :show]
	resources :item_types, only: [:index, :show], path: "borrow"
	resources :items, only: [:index, :show]
	resources :item_requests, only: [:create]

  get '/contact', to: "pages#contact", as: "contact"
  get '/alumni', to: "pages#alumni", as: "alumni"
  get '/cybergaming', to: "pages#cybergaming", as: "cybergaming"
  get '/about', to: "pages#about", as: "about"
  get '/election', to: "pages#election", as: "election"
  get '/profile', to: "profile#show", as: "profile"
  get '/mc17', to: "pages#mc17", as: "mc17"
  get '/recruitment', to: "pages#recruitment", as: "recruitment"

  get '/locker', to: "locker#home", as: "locker"
  resources :locker_ballots, only: [:create, :update, :destroy]

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
	
	root 'articles#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
