module Refinery
  class CopywritingGenerator < Rails::Generators::Base

    def rake_db
      rake("refinery_copywriting:install:migrations")
    end

    def append_load_seed_data
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by RefineryCMS Copywriting engine
Refinery::Copywriting::Engine.load_seed
        EOH
      end
    end

  end
end
