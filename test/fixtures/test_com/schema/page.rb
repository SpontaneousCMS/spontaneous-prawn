# encoding: UTF-8

require 'content'

class Page < Content::Page
  # pages must respond to the title method
  # so if you remove this 'title' field, then you must replace it with
  # a #title method
  field :title, :string, :default => "New Page"

  add_output :pdf
end
