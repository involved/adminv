module Adminv
  module Components
    class Header
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::UrlHelper
      attr_accessor :heading, :toggles, :search, :options, :html_options, :template

      def initialize(template, *args)
        @template = template
        @options = args.extract_options!
        extract_html_options!
        @heading = args.first.is_a?(Array) ? args.first.first : args.first
        @toggles = []
      end

      # creates a search box with an id, or something similar
      def search(id)
        @search = "input tag"
      end

      # creates a toggle link
      def link_to(*args)
        @toggles << super
      end

      def render(&block)
        @template.capture(self, &block) if block_given?
      end

      def to_s
        description = content_tag(:h3, @heading, :class => "block-description")
        toggle_button_items = []
        @toggles.each_with_index do |link, index|
          html_class = "pill button"
          if index == 0
            html_class += " left"
          elsif index == @toggles.count - 1
            html_class += " right"
          else
            html_class += " middle"
          end
          toggle_button_items << content_tag(:li, link, :class => html_class)
        end
        buttons = content_tag(:ul, toggle_button_items.join("").html_safe, :class => "block-toggles")
        content_tag(:div, (description + buttons).html_safe, :class => "block-header")
      end

      def extract_html_options!
        @html_options = {}
      end
    end
  end
end
