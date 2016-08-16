module Spontaneous
  module Prawn
    class Engine
      def initialize(roots, pdf_config)
        @roots = roots
        @pdf_config = pdf_config
      end

      def render(template, context, format)
        template(format, template).render(context)
      end

      def render_to_document(document, template, context, format)
        template(format, template).render_to_document(document, context)
      end

      def template(format, template)
        loaders[format].template(template)
      end

      def template_location(template, format)
        loaders[format].resolve(template)
      end

      def loaders
        @loaders ||= Hash.new { |h, k|
          h[k] = Spontaneous::Prawn::FileLoader.new(@roots, k, @pdf_config)
        }
      end
    end
  end
end
