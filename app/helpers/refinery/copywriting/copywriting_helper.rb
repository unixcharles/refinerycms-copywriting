module Refinery
  module Copywriting
    module CopywritingHelper
      def copywriting(name, options = {}, &block)
        options = @copywriting_options.merge(options) if @copywriting_options
        options[:default] = block_given? ? capture(&block) : options[:default]

        result = ::Refinery::Copywriting::Phrase.for(name, options)
      end

      def copywriting_options(options, &block)
        old_options = @copywriting_options
        @copywriting_options = @copywriting_options ? @copywriting_options.merge(options) : options
        yield
        @copywriting_options = old_options
      end
    end
  end
end
