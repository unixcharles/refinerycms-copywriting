Refinery::Admin::PagesController.class_eval do

  # Add :copywriting_phrases_attributes to page_params for strong parameters.
  def page_params_with_copywriting_phrases_params
    phrases_params = params.require(:page).permit(
      copywriting_phrases_attributes: [:id, :value]
    )
    page_params_without_copywriting_phrases_params.merge(phrases_params)
  end
  alias_method_chain :page_params, :copywriting_phrases_params

end
