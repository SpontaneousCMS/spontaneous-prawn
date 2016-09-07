module Spontaneous::Prawn
  module Context
    def asset_path(path, options = {})
      case (asset = _asset_environment.find_assets(path, options).first)
      when ::Sprockets::StaticAsset
        asset.pathname
      else
        asset
      end
    end

    def each_para(field, &block)
      Nokogiri::HTML(field.to_html).css('p').each do |para|
        block.call(para.inner_html)
      end
    end

    def html_text(pdf, field, text_options = {})
      margin = text_options.delete(:margin_bottom)
      opts = text_options.merge(inline_format: true)
      each_para(field) do |para|
        pdf.text(para, opts)
        pdf.move_down(margin)
      end
    end
  end
end
