module Spontaneous
  module Prawn
    class Template
      def initialize(source_reader, loader)
        @source = source_reader
        @loader = loader
      end

      def render(context, doc = nil)
        doc = document(context)
        render_to_document(doc, context)
        doc.__document.render
      end

      def render_to_document(document, context)
        context.__loader = @loader
        template_proc(context).call(document)
      end

      def pdf_options(context)
        context.__output.options[:config] || {}
      end

      def document(context)
        Spontaneous::Prawn::Document.new(context, pdf_options(context))
      end

      def template_proc(context)
        @template_proc ||= context.binding.eval(src)
      end

      def src
        @src ||= "proc { |pdf| #{@source.read} }"
      end
    end
  end
end
