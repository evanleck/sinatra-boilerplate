# =====================
# = Asset Tag Helpers =
# =====================
module Sinatra
  module AssetTagHelpers
    # javascript include tag
    def jit path
      "<script src='#{path}?v=#{ASSET_VERSION}'></script>"
    end

    # stylesheet link tag
    def slt path, media = 'screen', use_asset_version = true
      "<link href='#{path}#{ use_asset_version ? '?v='+ASSET_VERSION.to_s : '' }' media='#{media}' rel='stylesheet' type='text/css'>"
    end

    # image with src
    def image_tag path, o = {}
      "<img src='#{ path }?v=#{ ASSET_VERSION }' #{ o.to_attr }>"
    end
  end
  
  # comment this out if you don't want these methods included
  # or want to include them on your own
  helpers AssetTagHelpers
end

