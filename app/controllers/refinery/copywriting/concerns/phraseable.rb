module Refinery
  module Copywriting
    module Concerns
      class Phraseable
        # Add :copywriting_phrases_attributes to page_params for strong parameters.
        def object_params_with_copywriting_phrases_params
          phrases_params = params.require(:page).permit(
            copywriting_phrases_attributes: [:id, :value, :targetable_type, :targetable_id]
          )
          page_params_without_copywriting_phrases_params.merge(phrases_params)
        end
        alias_method_chain :page_params, :copywriting_phrases_params
      end
    end
  end
end
