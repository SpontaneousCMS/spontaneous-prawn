module Spontaneous
  module Prawn
    class FileLoader
      P = ::Spontaneous::Prawn

      attr_reader :format

      def initialize(roots, format)
        @roots = roots
        @format = format
      end

      def template(template)
        P::Template.new(open_template(template), self)
      end

      def open_template(template)
        template_path = resolve(template)
        raise UnknownTemplateError.new(@roots, filename(template)) if template_path.nil?
        # TODO: Make the encoding configurable?
        TemplateReader.new(template_path, Encoding::UTF_8)
      end

      def resolve(template_name)
        return template_name if ::File.exists?(template_name) # Test for an absolute path
        filename = filename(template_name)
        return filename if ::File.exists?(filename) # Test for an absolute path
        path_cache[filename]
      end

      def filename(template_name)
        [template_name, format, P::EXTENSION].join(P::DOT)
      end

      def path_cache
        @path_cache ||= Hash.new { |h, k|
          h[k] = paths(k).detect { |path| ::File.exists?(path) }
        }
      end

      def paths(filename)
        @roots.map { |root| ::File.join(root, filename) }
      end

      class TemplateReader
        def initialize(path, encoding)
          @path     = path
          @encoding = encoding
        end

        def read(*args)
          ::File.open(@path, 'r', external_encoding: @encoding) { |f| f.read }
        end

        def path
          @path
        end
      end
    end
  end
end

