module CopywritingHelper
  
  def copywriting(name, options = {}, &block)
	options = @copywriting_options.merge(options) if @copywriting_options
    options[:default] = block_given? ? capture(&block) : options[:default]

    result = ::CopywritingPhrase.for(name, options)

    options[:html_safe] ? result.html_safe : result
  end

  def copywriting_options(options, &block)
    @copywriting_options = options
    yield
    @copywriting_options = nil
  end
end