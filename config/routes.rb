Refinery::Core::Engine.routes.draw do
  namespace :copywriting, :path => '' do
    namespace :admin, :path => 'refinery' do
      scope :path => 'copywriting' do
        resources :phrases, :except => [:show, :new, :create] do
          collection do
            post :update_positions
          end
        end
      end
    end
  end
end
