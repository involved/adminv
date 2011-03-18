module Adminv
  module Components
    class Content
      include ActionView::Helpers::TagHelper
      attr_accessor :title, :header, :template, :options, :html_options, :html_content, :tab_id, :actions, :pagination

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

      def actions(&block)
        @actions = @template.capture(&block) if block_given?
      end

      def pagination(&block)
        @pagination = @template.capture(&block) if block_given?
      end

      def render(&block)
        @html_content = content_tag(:div, @template.capture(self, &block), :class => "block-content") if block_given?
      end

      # block-tab class may have to be moved into container, instead of here.
      def to_s
        if controls_html.blank?
          (@header.to_s + @html_content).html_safe
        else
          (@header.to_s + @html_content + content_tag(:div, controls_html, :class => 'block-controls')).html_safe
        end
      end

      private
      def controls_html
        controls_inner_html = ""
        controls_inner_html += content_tag(:div, @actions, :class => 'block-actions') if @actions
        controls_inner_html += content_tag(:div, @pagination, :class => 'block-pagination') if @pagination
        controls_inner_html.html_safe
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
