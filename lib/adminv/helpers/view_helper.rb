module Adminv
  module Helpers
    module ViewHelper
      def adminv_block(options = {})
        block = Adminv::Components::Block.new(options)
        yield block if block_given?
        block.to_s
      end
    end
  end
end
