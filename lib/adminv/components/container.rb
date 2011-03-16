module Adminv
  module Components
    class Container
      include ActionView::Helpers::TagHelper
      cattr_reader :width_options
      attr_accessor :content_areas, :options, :html_options
      @@width_options = {:full => 12, :with_sidebar => 9, :half => 6, :sidebar => 3}

      def initialize(*args)
        @header = ""
        @tables = []
        @content_areas = []
        extract_options!(args)
        extract_html_options!
      end

      # constructs a new table and appends it to the content_areas array
      def table(*args, &block)
        content_tag(:div, "Table content", :class => 'block-content table')# if block_given?
      end

      # constructs a new content area and appends it to the array
      def content(*args, &block)
        content_tag(:div, "Content content", :class => 'block-content')# if block_given?
      end

      # takes all the components and wraps them into the correct tags
      def to_s
        container = content_tag(:section, capture(&Proc.new), :class => "block-container")# if block_given?
        content_tag :section, container, @html_options
      end

      private
      # intializes block options
      def extract_options!(*args)
        @options = {}
        @options = args.first if args.first.is_a?(Hash)
        @options[:width] ||= :full
      end

      # intializes and extracts HTML-specific options
      def extract_html_options!
        @html_options = {}
        @html_options[:class] = ""
        [:id, :class].each do |key|
           if @options.has_key?(key)
             @html_options[key] == @options[key]
             @options.delete(key)
           end
        end

        @html_options[:class] = (@html_options[:class].split(" ") + ["block", "grid_#{@@width_options[@options[:width]]}", "tabs"]).join(" ")
      end
    end
  end
end
