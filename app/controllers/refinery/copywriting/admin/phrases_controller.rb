module Refinery
  module Copywriting
    module Admin
      class PhrasesController < ::Refinery::AdminController
        before_filter :find_all_locales, :find_locale, :find_scope, :find_all_scopes

        crudify :'refinery/copywriting/phrase', :searchable => false,
                :title_attribute => 'name', :xhr_paging => true, :sortable => false,
                :redirect_to_url => 'refinery.copywriting_admin_phrases_path'

        protected

        def find_all_phrases
          @phrases = Phrase.untargeted

          if find_scope
            @phrases = @phrases.for_scope(find_scope)
          end
        end

        def find_locale
          @current_locale ||= (params[:switch_locale].try(:to_sym) || Thread.current[:globalize_locale] || default_locale).to_sym
        end

        def find_all_locales
          @locales ||= ::Refinery::I18n.frontend_locales
        end

        def find_scope
          @scope ||= params[:filter_scope]
        end

        def find_all_scopes
          @scopes ||= Phrase.unscoped.untargeted.uniq.pluck(:scope)
        end

        def default_locale
          ::Refinery::I18n.default_frontend_locale
        end

        def globalize!
          super
          if params[:switch_locale]
            Thread.current[:globalize_locale] = (params[:switch_locale] || default_locale).try(:to_sym)
          end
        end

        def phrase_params
          params.require(:phrase).permit(
            :locale, :name, :default, :value, :scope, :page, :page_id,
            :phrase_type, :targetable_type, :targetable_id
          )
        end

      end
    end
  end
end
