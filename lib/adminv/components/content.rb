module Adminv
  module Components
    class Content
      include ActionView::Helpers::TagHelper
      attr_accessor :title, :header, :template, :options, :html_options, :html_content, :tab_id

      def initialize(template, *args)
        @template = template
        @tab_id = ActiveSupport::SecureRandom.hex(4)
        @options = args.extract_options!
        extract_html_options!
        @title = args.first
      end

      def header(*args, &block)
        hdr = Adminv::Components::Header.new(@template, args)
        hdr.render(&block)
        @header = hdr
        nil
      end

      def render(&block)
        @html_content = content_tag(:div, @template.capture(self, &block), :class => "block-content") if block_given?
      end

      # block-tab class may have to be moved into container, instead of here.
      def to_s
        (@header.to_s + @html_content).html_safe
      end

      def extract_html_options!
        @html_options = {}
        @html_options[:class] = ""
        [:id, :class].each do |key|
          if @options.has_key?(key)
            @html_options[key] == @options[key]
            @options.delete(key)
          end
        end
        #@html_options[:class] = (@html_options[:class].split(" ") + ["block", "grid_#{@@width_options[@options[:width]]}", "tabs"]).join(" ")
      end
    end
  end
end
