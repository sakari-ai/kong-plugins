package = "pixel"
version = "0.1.2-0"
source = {
  url = "https://github.com/sakari-ai/kong-plugins.git"
}
description = {
  summary = "A Kong plugin that sets different upstream URLs based on API and Consumer",
  license = "Apache 2.0"
}
dependencies = {
  "lua >= 5.1"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.grabid.handler"] = "kong/plugins/pixel/handler.lua",
    ["kong.plugins.grabid.client"] = "kong/plugins/pixel/schema.lua",
    ["kong.plugins.grabid.hmac"] = "kong/plugins/pixel/gzip.lua"
  }
}