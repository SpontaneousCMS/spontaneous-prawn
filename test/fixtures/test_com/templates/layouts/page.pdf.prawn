
pdf.text title

pdf.include "partials/image"

images.each do |image|
  pdf.render image
  pdf.start_new_page
end

