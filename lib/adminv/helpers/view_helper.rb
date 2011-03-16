module Adminv
  module Helpers
    module ViewHelper
      def adminv_container(options = {})
        container = Adminv::Components::Container.new(options)
        yield container if block_given?
        container.to_s
      end
    end
  end
end
