$LOAD_PATH.unshift 'lib'

Gem::Specification.new do |gem|
  gem.name     = 'minitest-rails-tools'
  gem.version  = '0.1.0'
  gem.date     = Time.now.strftime('%F')
  gem.summary  = 'Smoothen Minitest/Rails integration'
  gem.homepage = 'http://github.com/b4mboo/minitest-rails-tools'
  gem.email    = 'bamboo@suse.com'
  gem.authors  = ['Dominik Bamberger']

  gem.files         = %w( LICENSE README.md )
  gem.files        += Dir.glob("lib/**/*")
  gem.require_paths = ['lib']
  
  gem.description = 'A collection of little helpers to make working with Rails and Minitest a bit easier.'
end
