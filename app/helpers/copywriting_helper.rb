module CopywritingHelper
  
  def copywriting(name, options = {}, &block)
    options = @copywriting_options.merge(options) if @copywriting_options
    options[:default] = block_given? ? capture(&block) : options[:default]

    result = ::CopywritingPhrase.for(name, options)
  end

  def copywriting_options(options, &block)
    old_options = @copywriting_options
    @copywriting_options = @copywriting_options ? options : @copywriting_options.merge(options)
    yield
    @copywriting_options = old_options
  end
end