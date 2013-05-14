$LOAD_PATH.unshift 'lib'

Gem::Specification.new do |gem|
  gem.name     = 'minitest_rails_tools'
  gem.version  = open('VERSION').read.strip
  gem.date     = Time.now.strftime('%F')
  gem.summary  = 'Smoothen Minitest/Rails integration'
  gem.homepage = 'http://github.com/openSUSE/minitest_rails_tools'
  gem.email    = 'bamboo@suse.com'
  gem.authors  = ['Dominik Bamberger']

  gem.description = 'A collection of helpers for integrating Rails and Minitest.'

  gem.files         = %w( LICENSE README.md )
  gem.files        += Dir.glob('lib/**/*')
  gem.require_paths = ['lib']
  gem.add_runtime_dependency 'rails'
  gem.add_runtime_dependency 'minitest'
end
