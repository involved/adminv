module Adminv
  module Components
    class Block
      include ActionView::Helpers::TagHelper
      cattr_reader :width_options
      attr_accessor :header, :tabs, :tables, :options, :html_options
      @@width_options = {:full => 12, :with_sidebar => 9, :half => 6, :sidebar => 3}

      def initialize(*args)
        @header = ""
        @tabs = []
        @tables = []
        extract_options!(args)
        extract_html_options!
      end

      # constructs a new header
      def header(*args)

      end

      # constructs a tab an appends it to the tabs array
      def tab(*args)

      end

      # constracuts a new table and appends it to the tables array
      def table(*args)

      end

      # place to dump all other content - in which case, 'table' should probably a method of BlockContent, not of Block
      def content(*args)

      end

      # takes all the components and wraps them into the correct tags
      def to_s
        content_tag :section, "Block content #{content}", @html_options
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

        @html_options[:class] = (@html_options[:class].split(" ") + ["block", "grid_#{@@width_options[@options[:width]]}"]).join(" ")
      end
    end
  end
end
