module Adminv
  module Components
    class Container
      include ActionView::Helpers::TagHelper
      include ActionView::Helpers::UrlHelper
      cattr_reader :width_options
      attr_accessor :template, :content_areas, :options, :html_options
      @@width_options = {:full => 12, :with_sidebar => 9, :grid7 => 7, :half => 6, :sidebar => 3, :grid2 => 2}

      def initialize(template, *args, &block)
        @template = template
        @header = ""
        @tables = []
        @content_areas = []
        @options = args.extract_options!
        @options[:width] ||= :full
        extract_html_options!
      end

      # constructs a new table and appends it to the content_areas array
      def table(*args, &block)
        table = Adminv::Components::Table.new(@template, args)
        table.render(&block)
        content_areas << table
      end

      # constructs a new content area and appends it to the array
      def content(*args, &block)
        content = Adminv::Components::Content.new(@template, args)
        content.render(&block)
        content_areas << content
        nil
      end

      def render(&block)
        # should stash the html content, incase no content blocks are created, and insert that content into one
        @template.capture(self, &block) if block_given?
      end

      def to_s
        if content_areas.count > 1
          tabs = content_areas.map{ |content_area| content_tag(:li, link_to(content_area.title || "Tab Title", "#tab_#{content_area.tab_id}")) }.join("").html_safe
          tabs = content_tag(:nav, content_tag(:ul, tabs), :class => 'block-tabs')
          content = content_tag(:section, content_areas.map{|content_area| content_tag(:div, content_area.to_s, :id => "tab_#{content_area.tab_id}", :class => "block-tab")}.join("").html_safe, :class => 'block-container')
          content_tag :section, tabs + content, @html_options
        else
          content = content_tag :section, content_tag(:section, content_areas.first.to_s, :class => "block-container"), @html_options
        end
      end

      private
      # intializes and extracts HTML-specific options
      def extract_html_options!
        @html_options = {}
        @html_options[:class] = ""
        [:id, :class].each do |key|
           if @options.has_key?(key)
             @html_options[key] = @options[key]
             @options.delete(key)
           end
        end
        @html_options[:class] = (@html_options[:class].split(" ") + ["block", "grid_#{@@width_options[@options[:width]]}", "tabs"]).join(" ")
      end
    end
  end
end
