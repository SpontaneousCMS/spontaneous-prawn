require 'spontaneous/prawn/renderer'

module Spontaneous
  module Prawn
    class Output < ::Spontaneous::Output::Format
      provides_format :pdf, :pdf_prawn

      def default_renderer
        opts = options[:config] || {}
        Spontaneous::Prawn::Renderer.new(Spontaneous.instance, opts)
      end
    end
  end
end

