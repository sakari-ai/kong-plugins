package = "gzip"
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
    ["kong.plugins.gzip.handler"] = "kong/plugins/gzip/handler.lua",
    ["kong.plugins.gzip.schema"] = "kong/plugins/gzip/schema.lua",
    ["kong.plugins.gzip.gzip"] = "kong/plugins/gzip/gzip.lua"
  }
}