module Adminv
  module Helpers
    module FormHelper
      def add_remove_row(form, association, options={})
        add_row(form, association, options) + remove_row(form)
      end

      def add_row(form, association, options={})
        options[:label] ||= "+"
        new_child_fields_template(form, association, options) + link_to(options[:label], "javascript:void(0)", :class => "add_remove_toggle add_row", :"data-association" => association, :"data-max-rows" => options[:max_rows])
      end

      def remove_row(form)
        form.hidden_field(:_destroy) + link_to("-", "javascript:void(0)", :class => "add_remove_toggle remove_row")
      end

      def new_child_fields_template(form_builder, association, options = {})
        options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
        options[:partial] ||= association.to_s.singularize
        options[:form_builder_local] ||= :f
        options[:locals] ||= {}

        content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
          fields_for_method = :fields_for
          if defined?(SimpleForm)
            fields_for_method = :simple_fields_for
          elsif defined?(Formtastic)
            fields_for_method = :semantic_fields_for
          end
          form_builder.simple_fields_for( association, options[:object], :child_index => "new_#{association}") do |f|
            options[:locals][options[:form_builder_local]] = f
            render(:partial => options[:partial], :locals => options[:locals])
          end
        end
      end
    end
  end
end
