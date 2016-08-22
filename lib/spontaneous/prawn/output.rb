require 'spontaneous/prawn/renderer'

module Spontaneous
  module Prawn
    class Output < ::Spontaneous::Output::Format
      provides_format :pdf, :pdf_prawn

      module ClassMethods
        def default_renderer(site)
          Spontaneous::Prawn::Renderer.new(site)
        end

        def preview_renderer(site)
          Spontaneous::Prawn::Renderer.new(site)
        end
      end

      extend ClassMethods

      def default_renderer(site = Spontaneous.instance)
        prawn_renderer(site)
      end

      def publish_renderer(transaction)
        prawn_renderer(transaction.site)
      end

      def prawn_renderer(site)
        Spontaneous::Prawn::Renderer.new(site)
      end
    end
  end
end

