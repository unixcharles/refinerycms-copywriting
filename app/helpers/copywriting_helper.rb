module CopywritingHelper
  
  def copywriting(name, options = {}, &block)
    options[:default] = block_given? ? capture(&block) : options[:default]
    ::CopywritingPhrase.for(name, options)
  end

end