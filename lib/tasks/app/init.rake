require 'fileutils'

namespace :nard do
  namespace :app do

    desc 'initialize'
    task init: :environment do
      h = {
        locale_devise: {
          before: File.join( Rails.root, 'config', 'locales', 'devise.en.yml' ) ,
          after: File.join( Rails.root, 'config', 'locales', 'devise', 'en.yml' )
        },
        locale_normal_en: {
          before: File.join( Rails.root, 'config', 'locales', 'en.yml' ) ,
          after: File.join( Rails.root, 'config', 'locales', 'normal', 'en.yml' )
        },
        locale_normal_ja: {
          before: File.join( Rails.root, 'config', 'locales', 'ja.yml' ) ,
          after: File.join( Rails.root, 'config', 'locales', 'normal', 'ja.yml' )
        },
        bootstrap_locale_en: {
          before: File.join( Rails.root, 'config', 'locales', 'en.bootstrap.yml' ) ,
          after: File.join( Rails.root, 'config', 'locales', 'bootstrap', 'en.yml' )
        }
      }

      h.values.each do |h_before_and_after|
        if File.exist?( h_before_and_after[:before] )
          FileUtils.mkdir_p( File.dirname( h_before_and_after[:after] ) )
          File.rename( *(h_before_and_after.values) )
        end
      end
    end

  end
end
