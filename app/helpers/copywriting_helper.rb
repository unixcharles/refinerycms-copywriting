module CopywritingHelper
  def copywriting(name, options = {}, &block)
    scope   = options[:scope] || 'default'
    page_id = options[:page_id] || options[:page].try(:id) || nil
    default = block_given? ? capture(&block) : options[:default]

    result = ::CopywritingPhrase.for(name, scope, default, page_id)
  end
end