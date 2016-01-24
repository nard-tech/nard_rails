require 'yard'
require 'yard-rails'
require 'yard-activesupport-concern'

# @note task :yard do ... end の記述は不要
YARD::Rake::YardocTask.new do |t|
  t.files = ["#{Rails.root}/app/**/*.rb"]
  t.options = ['--plugin yard-rails', '--title-tag title:DRS Cloud'] # optional
  t.stats_options = [] # optional
end
