# encoding: UTF-8

require 'content'

class Piece < Content::Piece
end

class Image < Piece
  field :image do
    size :thumbnail do
      width 400
    end
  end
  field :title
end
