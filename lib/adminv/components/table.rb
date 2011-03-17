module Adminv
  module Components
    class Table < Adminv::Components::Content
      include ActionView::Helpers::TagHelper
      attr_accessor :rows
      
      def initialize(template, *args, &block)
        super
        @rows = []
      end

      # a table row
      def row(&block)
        row = Adminv::Components::TableRow.new(@template, false)
        row.render(&block)
        rows << row
      end

      # this is just a 'row' but with the heading property set
      def headings(*args, &block)
        row = Adminv::Components::TableRow.new(@template, true)
        row.cols(args)
        row.render(&block)
        rows << row
      end

      def render(&block)
        @template.capture(self, &block) if block_given?
      end

      def to_s
        content_tag(:div, content_tag(:table, rows.map{ |row| row.to_s }.join("").html_safe, :width => "100%"), :class => "block-content table")
      end

    end
  end
end
