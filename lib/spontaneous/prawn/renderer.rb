require 'prawn'

module Spontaneous
  module Prawn
    class Renderer < Spontaneous::Output::Template::Renderer
      attr_reader :site, :config, :engine

      def initialize(site, config)
        @site = site
        @config = config
        @engine = Spontaneous::Prawn::Engine.new(site.paths(:templates))
      end

      def _render(content, context, format)
        # render_template(template_path(content, format), context, format)
        engine.render(template_path(content, format), context, format)
      end

      def _render_string(template_string, context, format)
        p [:_render_string, template_string]
      end

      def template_exists?(template, format)
        false
      end

      def template_location(template, format)
        @engine.template_location(template, format)
      end

      def template_path(content, format)
        p [:content_template, content.template(format, self)]
        content.template(format, self)
      end


      # TODO: dynamic pdfs?
      def is_dynamic_template?(pdf)
        false
      end
    end
  end
end


