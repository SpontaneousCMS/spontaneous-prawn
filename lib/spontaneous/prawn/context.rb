module Spontaneous::Prawn
  module Context
    def asset_path(path, options = {})
      asset = _asset_environment.find_assets(path, options).first
      asset.pathname.to_s
    end
  end
end
