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
  end
end
