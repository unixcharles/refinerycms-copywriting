require 'refinerycms-core'

module Refinery
  autoload :CopywritingGenerator, 'generators/refinery/copywriting/copywriting_generator'

  module Copywriting
    require 'refinery/copywriting/engine'

    class << self
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end
    end

    def self.table_name_prefix
      'refinery_cw_'
    end

  end
end
