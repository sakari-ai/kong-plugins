local BasePlugin = require "kong.plugins.base_plugin"
local gzip = require "kong.plugins.gzip.gzip"

local GZIPHandler = BasePlugin:extend()
GZIPHandler.PRIORITY = 2100
GZIPHandler.VERSION = "0.1.0"

GZIPHandler.ERRORS = ERRORS

function GZIPHandler:new()
    GZIPHandler.super.new(self, "gzip")
end

function GZIPHandler:access(conf)
    GZIPHandler.super.access(self)
    encode = kong.request.get_header("Content-Encoding")
    if encode == "gzip" then
        local data = kong.request.get_raw_body()

        if data ~= '' then
            local new_data = gzip.inflate_body(data)

            kong.service.request.clear_header("Content-Encoding")
            kong.service.request.clear_header("Content-Length")
            kong.service.request.set_raw_body(new_data)
        end
    end
end

return GZIPHandler
