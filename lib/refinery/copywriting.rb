module Refinery
  autoload :CopywritingGenerator, 'generators/refinery/copywriting/copywriting_generator'

  module Copywriting
    class << self
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end
    end
  end
end

require 'refinery/copywriting/engine'
