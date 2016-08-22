require 'prawn'

module Spontaneous
  module Prawn
    class Renderer < Spontaneous::Output::Template::Renderer
      attr_reader :site, :engine

      def initialize(site)
        @site = site
        @engine = Spontaneous::Prawn::Engine.new(site.paths(:templates))
      end

      def _render(content, context, format)
        engine.render(template_path(content, format), context, format)
      end

      def _render_string(template_string, context, format)
        # TODO: do I need this?
      end

      def template_exists?(template, format)
        false
      end

      def template_location(template, format)
        @engine.template_location(template, format)
      end

      def template_path(content, format)
        content.template(format, self)
      end

      def for_document(document)
        DocumentRenderer.new(@site, document)
      end

      # TODO: dynamic pdfs?
      def is_dynamic_template?(pdf)
        false
      end
    end

    # Provides a renderer that writes into an existing document, used when
    # writing pieces etc into a document
    class DocumentRenderer < Renderer
      def initialize(site, document)
        super(site)
        @document = document
      end

      def _render(content, context, format)
        engine.render_to_document(@document, template_path(content, format), context, format)
      end
    end
  end
end


