module Adminv
  module Helpers
    module ViewHelper
      def adminv_container(options = {}, &block)
        container = Adminv::Components::Container.new(self, options)
        container.render(&block)
        container.to_s
      end
      def page_id(new_id)
        content_for(:page_id){ new_id }
      end
    end
  end
end
