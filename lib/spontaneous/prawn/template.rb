module Spontaneous
  module Prawn
    class Template
      def initialize(source_reader, loader)
        @source = source_reader
        @loader = loader
      end

      def render(context)
        context.__loader = @loader
        doc = document(context)
        template_proc(context).call(doc)
        doc.__document.render_file "page.pdf"
        doc.__document.render
      end

      def document(context)
        # p [: PASS_OPTIONS!]
        Document.new(context, {})
      end

      class Document < BasicObject
        attr_reader :__document

        def initialize(context, options)
          @__context = context
          @__document = ::Prawn::Document.new(options)
        end

        def respond_to_missing?(method_name, include_private = false)
          __document.respond_to?(method_name, include_private)
        end

        def method_missing(method_name, *args)
          document_args = args.map { |arg| @__context.__decode_params(arg) }
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
end
