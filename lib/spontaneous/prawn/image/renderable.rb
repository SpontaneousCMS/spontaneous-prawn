
module Spontaneous::Media::Image::Renderable
  # Render an image to a PDF by returning it as an IO object
  def to_pdf(opts = {})
    storage.read(value)
  end
end
