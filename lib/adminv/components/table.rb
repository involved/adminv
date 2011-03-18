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
        rows_html = rows.map{ |row| row.to_s }.join("").html_safe
        if rows.empty? || (rows.count == 1 && rows.first.is_heading)
          col_count = 1
          col_count = rows.first.columns.count if rows.any? && rows.first.columns.any?
          rows_html += content_tag(:tr, content_tag(:td, "No records found.", :colspan => col_count))
        end

        if controls_html.blank?
          content_tag(:div, (@header.to_s + content_tag(:table, rows_html, :width => "100%")).html_safe, :class => "block-content table")
        else
          content_tag(:div, (@header.to_s + content_tag(:table, rows_html, :width => "100%") + controls_html).html_safe, :class => "block-content table")
        end
      end
    end
  end
end
