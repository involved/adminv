module Adminv
  module Helpers
    module ViewHelper
      def adminv_container(options = {}, &block)
        container = Adminv::Components::Container.new(self, options)
        container.render(&block)
        container.to_s
      end

      # sets the page title
      def title(page_title, page_subtitle = nil)
        content_for(:title) { page_title }
        subtitle(page_subtitle) if page_subtitle
      end

      def subtitle(page_title)
        content_for(:subtitle) {page_title}
      end

      def page_id(new_id)
        content_for(:page_id){ new_id }
      end

      def back_block(options = {})
        options[:alternative_resource_class] = resource_class if options[:alternative_resource_class].blank?
        render :partial => 'shared/back', :locals => {:namespace => options[:namespace], :alternative_resource_class => options[:alternative_resource_class]}
      end

      def sidebar_right(options = {})
        render :partial => 'shared/sidebar_right', :locals => {:namespace => options[:namespace]}
      end

      def empty_row(collection, name, &block)
        # should capture the block and inject into the front of the button group aswell?
        render :partial => 'shared/empty_row', :locals => {:name => name} if collection.empty?
      end

      def avatar_url(user, options = {})
        options[:size] ||= 64
        gravatar_id = user.is_a?(String) ? Digest::MD5::hexdigest(user).downcase : Digest::MD5::hexdigest(user.email).downcase
        "http://gravatar.com/avatar/#{gravatar_id}.png?d=mm&r=pg&s=#{options[:size]}"
      end

      def avatar(user, options = {})
        options[:size] ||= 64
        image_tag avatar_url(user, options), :width => options[:size], :height => options[:size]
      end

      def boolean_for(bool)
        image_tag bool ? 'adminv/ui-icon_status-true.png' : 'adminv/ui-icon_status-false.png'
      end

    end
  end
end

