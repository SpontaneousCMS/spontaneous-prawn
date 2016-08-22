module Spontaneous
  module Prawn
    class Document
      attr_reader :__document

      def initialize(context, options)
        @__context = context
        @__document = ::Prawn::Document.new(options)
      end

      def include(template_name, locals = {})
        context = @__context.clone(locals)
        @__context.__loader.template(template_name).render_to_document(self, context)
      end

      def render(content)
        content.render_inline_using(@__context._renderer.for_document(self), @__context.__format, {}, @__context)
      end

      def respond_to_missing?(method_name, include_private = false)
        __document.respond_to?(method_name, include_private)
      end

      def method_missing(method_name, *args)
        document_args = args.map { |arg| @__context.__decode_params(arg, false) }
        # $stdout.puts [:missing, method_name,args, document_args].inspect
        if ::Kernel.block_given?
          __document.send(method_name, *document_args, &Proc.new)
        else
          __document.send(method_name, *document_args)
        end
      end
    end

    def template_proc(context)
      @template_proc ||= context.binding.eval(src)
    end

    def src
      @src ||= "proc { |pdf| #{@source.read} }"
    end
  end
end
