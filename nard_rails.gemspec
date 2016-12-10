$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nard_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = 'nard_rails'
  s.version = Nard::Rails::VERSION
  s.authors = [ 'Shu Fujita' ]
  s.email = [ 's.fujita@nard.tech' ]
  s.homepage = 'https://github.com/nard-tech/nard_rails'
  s.summary = 'NardRails.'
  s.description = 'NardRails.'
  s.license = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.2.5"
  s.add_dependency 'twitter'
  s.add_dependency 'settingslogic'

  s.add_dependency 'draper'
  s.add_dependency 'kaminari'
  s.add_dependency 'simple_form'

  s.add_dependency 'yard'
  s.add_dependency 'yard-rails'
  s.add_dependency 'yard-activesupport-concern'

  s.add_development_dependency 'sqlite3'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  s.add_development_dependency 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  s.add_development_dependency 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  s.add_development_dependency 'spring' , '1.3.6'

  s.add_development_dependency 'rspec', '~> 3.4.0'
  s.add_development_dependency 'rspec-rails'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'pry-byebug'
  # ブラウザ上にエラーの詳細を表示
  s.add_development_dependency 'better_errors'
  # テスト実行時のシステムの時刻を任意に設定
  s.add_development_dependency 'timecop'

end


# spec.add_development_dependency "bundler", "~> 1.11"
# spec.add_development_dependency "rake", "~> 10.0"
# spec.add_development_dependency "rspec", "~> 3.0"

# spec.add_runtime_dependency 'activesupport'
# spec.add_runtime_dependency 'actionmailer'
# spec.add_runtime_dependency 'kaminari'
