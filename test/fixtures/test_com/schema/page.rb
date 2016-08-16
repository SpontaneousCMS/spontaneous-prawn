# encoding: UTF-8

require 'content'

class Page < Content::Page
  add_output :pdf, config: { page_size: "A5", page_layout: :portrait, margin: 0 }

  # pages must respond to the title method
  # so if you remove this 'title' field, then you must replace it with
  # a #title method
  field :title, :string, default: "New Page"
  field :image do
    size :inline do
      width 500
    end
  end

  box :images do
    allow :Image
  end
end
