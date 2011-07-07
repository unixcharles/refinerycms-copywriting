module CopywritingHelper
  
  def copywriting(name, options = {}, &block)
    options[:default] = block_given? ? capture(&block) : options[:default]

    result = ::CopywritingPhrase.for(name, options)

    options[:html_safe] ? result.html_safe : result
  end

end