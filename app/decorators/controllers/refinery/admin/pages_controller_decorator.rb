module RefineryCopywritingControllerDecorator
  def permitted_page_params
    params[:page][:copywriting_phrases_attributes]={} if params[:page][:copywriting_phrases_attributes].nil?
    super <<  [copywriting_phrases_attributes: [:id, :value]]
  end
end

Refinery::Admin::PagesController.send :prepend, RefineryCopywritingControllerDecorator