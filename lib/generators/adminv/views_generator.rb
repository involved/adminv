module Menumatic
  module Generators
    class ViewsGenerator < Rails:Generators::Base
      desc "Creates adminv application views"
      source_root File.expand_path('../temlpates', __FILE__)
      class_options :layout, :type => :boolean, :default => false, :description => "Include layout file"

      def generate_views
        copy_file "app/views/layouts/adminv.html.erb", "app/views/layouts/adminv.html.erb" if options.layout?
        copy_file "public/stylesheets/adminv/adminv.css", "public/stylesheets/adminv/adminv.css"
        copy_file "public/stylesheets/adminv/styles.css", "public/stylesheets/adminv/styles.css"
      end
    end
  end
end
