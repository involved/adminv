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
        @html_content = content_tag(:div, @template.capture(self, &block), :class => "block-table") if block_given?
      end

      # block-tab class may have to be moved into container, instead of here.
      def to_s
        if controls_html.blank?
          (@header.to_s + @html_content).html_safe
        else
          (@header.to_s + @html_content + content_tag(:div, controls_html, :class => 'block-table')).html_safe
        end
      end

      def to_s_old
        rows_html = rows.map{ |row| row.to_s }.join("").html_safe
        if rows.empty? || (rows.count == 1 && rows.first.is_heading)
          col_count = 1
          col_count = rows.first.columns.count if rows.any? && rows.first.columns.any?
          rows_html += content_tag(:tr, content_tag(:td, "No records found.", :colspan => col_count))
        end

        if controls_html.blank?
          content_tag(:div, (@header.to_s + content_tag(:div, rows_html, :width => "100%")).html_safe, :class => "block-table")
        else
          content_tag(:div, (@header.to_s + content_tag(:div, rows_html, :width => "100%") + controls_html).html_safe, :class => "block-table")
        end
      end
    end
  end
end
