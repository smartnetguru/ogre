Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  # Pasted from devise:install
  # 2. Ensure you have defined root_url to *something* in your config/routes.rb.
  # For example:
  #
  #     root to: "home#index"

  # You can have the root of your site routed with "root"
  root 'home#index'

  get 'resume/:id/json' => 'resume#export_json'
  get 'resume/:id/txt' => 'resume#export_txt'
  get 'resume/:id/html' => 'resume#export_html'
  get 'resume/:id/pdf' => 'resume#export_pdf'
  get 'resume/:id/doc' => 'resume#export_doc'
  get 'resume/:id/duplicate' => 'resume#duplicate'
  get 'resume/:id/reset_preview_key' => 'resume#reset_preview_key'

  get 'education/:id/delete' => 'education#delete'
  resources :education

  patch 'resume/:id/update_skill_order' => 'resume#update_skill_order'
  patch 'resume/:id/update_educations' => 'resume#update_educations'
  patch 'resume/:id/update_resps' => 'resume#update_resps'
  patch 'resume/:id/update_projects' => 'resume#update_projects'
  patch 'resume/:id/new_skill' => 'resume#new_skill'
  get 'resume/:id/delete' => 'resume#delete'
  resources :resume

  patch 'job/new_resp' => 'job#new_resp'
  patch 'job/:id/update_resps' => 'job#update_resps'
  get 'job/:id/delete' => 'job#delete'
  resources :job

  get 'responsibility/:id/delete' => 'responsibility#delete'
  resources :responsibility

  get 'project/:id/delete' => 'project#delete'
  resources :project

  get 'skill/:id/delete' => 'skill#delete'
  resources :skill

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
