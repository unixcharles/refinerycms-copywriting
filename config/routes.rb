Refinery::Application.routes.draw do
  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :copywriting_phrases, :path => 'copywriting', :except => [:show, :new, :create] do
      collection do
        post :update_positions
      end
    end
  end
end
