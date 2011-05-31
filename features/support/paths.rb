module NavigationHelpers
  module Refinery
    module Copywritings
      def path_to(page_name)
        case page_name
        when /the list of copywritings/
          admin_copywriting_phrases_path
        else
          nil
        end
      end
    end
  end
end
