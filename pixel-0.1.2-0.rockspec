package = "pixel"
version = "0.1.2-0"
source = {
  url = "https://github.com/sakari-ai/kong-plugins.git"
}
description = {
  summary = "A Kong plugin that support Gzip-Compression via Content-Encoding",
  license = "Apache 2.0"
}
dependencies = {
  "lua >= 5.1"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.pixel.handler"] = "kong/plugins/pixel/handler.lua",
    ["kong.plugins.pixel.schema"] = "kong/plugins/pixel/schema.lua",
    ["kong.plugins.pixel.gzip"] = "kong/plugins/pixel/gzip.lua"
  }
}