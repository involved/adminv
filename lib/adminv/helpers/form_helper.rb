module Adminv
  module Helpers
    module FormHelper
      def add_remove_row(form, association, options={})
        options_add = options
        options_remove = options
        options_add[:link_method] = :positive_add_pill_button_link_to
        options_remove[:link_method] = :negative_remove_pill_button_link_to
        button_group do
          add_row(form, association, options)
          remove_row(form, options)
        end
      end

      def add_row(form, association, options={})
        options[:label] ||= "add"
        options[:link_method] ||= :positive_add_button_link_to
        options[:target] ||= ""
        new_child_fields_template(form, association, options) + send(options[:link_method], options[:label], "javascript:void(0)", :class => "add_remove_toggle add_row", :"data-association" => association, :"data-max-rows" => options[:max_rows], :"data-target" => options[:target])
      end

      def clone_row(form, association, target, options={})
        options[:label] ||= "add"
        options[:link_method] ||= :positive_add_button_link_to
        send(options[:link_method], options[:label], "javascript:void(0)", :class => "add_remove_toggle add_row", :"data-association" => association, :"data-max-rows" => options[:max_rows], :"data-template-target" => target)
      end

      def remove_row(form, options = {})
        options[:label] ||= "remove"
        options[:link_method] ||= :negative_remove_button_link_to
        link_class = "add_remove_toggle remove_row"
        link_class += " #{options[:class]}" if options[:class].to_s
        form.hidden_field(:_destroy) + send(options[:link_method] ,options[:label], "javascript:void(0)", :class => link_class)
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
