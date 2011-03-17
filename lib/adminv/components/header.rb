module Adminv
  module Components
    class Header
      include ActionView::Helpers::TagHelper
      attr_accessor :heading, :toggles, :options, :html_options, :template

      def initialize(template, *args)
        @template = tempplate
        @options = args.extract_options!
        extract_html_options!
        @heading = args.first if args.any? && args.first.is_a(String)
      end

      def link_to(*args)
        # alias for actual link_to, might need to use alias_method_chain here
      end

      def render(&block)
        @template.capture(self, &block) if block_given?
      end

      def to_s
        content_tag(:div, @heading, :class => "block-header")
      end
    end
  end
end
