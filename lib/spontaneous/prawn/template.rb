module Spontaneous
  module Prawn
    class Template
      def initialize(source_reader, loader, pdf_config)
        @source = source_reader
        @loader = loader
        @pdf_config = pdf_config
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

      def document(context)
        Spontaneous::Prawn::Document.new(context, @pdf_config)
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
