require 'spontaneous'
require 'prawn/measurement_extensions'

module Spontaneous
  module Prawn
    FORMAT = "pdf".freeze
    EXTENSION = "prawn".freeze
    DOT = ".".freeze

    class UnknownTemplateError < Exception
      def initialize(template_roots, relative_path)
        super("Template '#{relative_path}' not found under #{template_roots.inspect}")
      end
    end
  end
end

require 'spontaneous/prawn/version'
require 'spontaneous/prawn/output'
require 'spontaneous/prawn/renderer'
require 'spontaneous/prawn/engine'
require 'spontaneous/prawn/file_loader'
require 'spontaneous/prawn/template'
require 'spontaneous/prawn/document'
require 'spontaneous/prawn/image/renderable'

