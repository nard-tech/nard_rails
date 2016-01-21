require 'rails/all'
require 'require_all'

require 'nard_rails'

module Nard
  module Rails
    class Engine < ::Rails::Engine

      config.to_prepare do
        Dir.glob(Nard::Rails::Engine.root + "app/errors/**/**.rb").each do |c|
          require_dependency(c)
        end
        Dir.glob(Nard::Rails::Engine.root + "app/services/**/**.rb").each do |c|
          require_dependency(c)
        end
      end

      config.i18n.load_path += Dir[ Nard::Rails::Engine.root.join( 'config' , 'locales' , '**' , '*.{rb,yml}' ).to_s ]

    end
  end
end

[ 'controller_ext', 'model_ext', 'decorator_ext' ].each do | dirname |
  require_relative "./#{dirname}"
  require_all File.join( Nard::Rails::Engine.root, 'lib', 'nard_rails', dirname, '**', '**.rb' )
end
