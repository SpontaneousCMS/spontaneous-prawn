require 'spontaneous/prawn/renderer'

module Spontaneous
  module Prawn
    class Output < ::Spontaneous::Output::Format
      provides_format :pdf, :pdf_prawn

      def default_renderer
        prawn_renderer(Spontaneous.instance)
      end

      def publish_renderer(transaction)
        prawn_renderer(transaction.site)
      end

      def pdf_options
        options[:config] || {}
      end

      def prawn_renderer(site)
        Spontaneous::Prawn::Renderer.new(site, pdf_options)
      end
    end
  end
end

