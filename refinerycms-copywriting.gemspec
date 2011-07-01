Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-copywriting'
  s.version           = '1.0.4'
  s.date              = '2011-07-01'
  s.description       = 'Extract all your strings and leave no human word behind, with i18n'
  s.summary           = 'Refinery CMS engine to manage copywriting, application wide or per pages, with i18n.'
  s.author            = 'Charles Barbier'
  s.email             = 'unixcharles@gmail.com'
  s.homepage          = 'http://github.com/unixcharles/refinerycms-copywriting'
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*', 'db/**/*', 'spec/**/*', 'features/**/*']
end
