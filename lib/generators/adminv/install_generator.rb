module Adminv
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Creates adminv application views"
      source_root File.expand_path('../templates', __FILE__)
      class_option :layout, :type => :boolean, :default => false, :description => "Include layout file"

      def generate_install
        copy_file "app/views/layouts/adminv.html.erb", "app/views/layouts/adminv.html.erb" if options.layout?
        directory "app/views/adminv"
        directory "public/stylesheets/adminv"
        directory "public/images/adminv"
        directory "public/javascripts/adminv"
      end
    end
  end
end
