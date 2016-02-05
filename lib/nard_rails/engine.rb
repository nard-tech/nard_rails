require 'rails/all'
require 'require_all'

require 'nard_rails'
require 'twitter'

module Nard
  module Rails
    class Engine < ::Rails::Engine

      config.to_prepare do
        [ 'errors', 'services', 'inputs' ].each do | dir |
          Dir.glob("#{ Nard::Rails::Engine.root }/app/#{ dir }/**/**.rb").each do |c|
            require_dependency(c)
          end
        end
      end

      config.i18n.load_path += Dir[ Nard::Rails::Engine.root.join( 'config' , 'locales' , '**' , '*.{rb,yml}' ).to_s ]

      ::Rails::Application.class_eval do
        def on_sqale?
          ::Rails.env.production? and ::ENV['HOME'].present? and ::ENV['HOME'] == '/home/sqale'
        end
      end

    end
  end
end

[ 'controller_ext', 'model_ext', 'decorator_ext', 'gem_ext' ].each do | dirname |
  require_relative "./#{dirname}"
  require_all File.join( Nard::Rails::Engine.root, 'lib', 'nard_rails', dirname, '**', '**.rb' )
end
