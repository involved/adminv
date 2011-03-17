module Adminv
  module Components
    class TableRow
      include ActionView::Helpers::TagHelper

      attr_reader :template, :is_heading, :columns

      def initialize(template, is_heading = false, &block)
        @template = template
        @is_heading = is_heading
        @columns = []
      end

      def col(value)
        self.cols([value])
      end

      def cols(values)
        @columns += Array(values)
      end

      def render(&block)
        @template.capture(self, &block) if block_given?
      end

      def to_s
        cell_tag = self.is_heading ? :th : :td
        content_tag(:tr, @columns.map{ |column| content_tag(cell_tag, column) }.join("").html_safe)
      end

    end
  end
end
