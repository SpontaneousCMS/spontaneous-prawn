module Spontaneous
  module Prawn
    class Engine
      def initialize(roots)
        @roots = roots
      end

      def render(template, context, format)
        loaders[format].template(template).render(context)
      end

      def template_location(template, format)
        loaders[format].resolve(template)
      end

      def loaders
        @loaders ||= Hash.new { |h, k|
          h[k] = Spontaneous::Prawn::FileLoader.new(@roots, k)
        }
      end
    end
  end
end
