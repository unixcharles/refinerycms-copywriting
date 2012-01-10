Rails.application.routes.draw do
  scope(:path => 'refinery', :module => 'refinery', :as => 'refinery') do
    scope(:as => 'copywriting', :path => 'copywriting', :module => 'copywriting') do
      scope(:as => 'admin', :module => 'admin') do
        resources :phrases, :except => [:show, :new, :create] do
          collection do
            post :update_positions
          end
        end
      end
    end
  end
end
