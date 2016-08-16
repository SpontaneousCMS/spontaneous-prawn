y_position = pdf.cursor
# pdf.span(148.mm) do
# pdf.bounding_box([0, pdf.cursor], width: 148.mm, height: 100.mm) do
pdf.pad(5.mm) do
  pdf.text title
  # pdf.image image.thumbnail, at: [200, y_position]
  pdf.image image, width: 148.mm
end
# end
# end
