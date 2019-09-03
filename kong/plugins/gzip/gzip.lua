local function create_error_response (code, description)
    ngx.status = ngx.HTTP_BAD_REQUEST
    ngx.header.content_type = "application/json"

    kong.response.exit(code, { message = description })
end

local _Gzip = {}

function _Gzip.inflate_body(data)
    ngx.ctx.max_chunk_size = 16384 -- 16Kb
    ngx.ctx.max_body_size = 20971520 -- 20Mb
    local stream = require("zlib").inflate()
    local buffer = ""
    local chunk = ""

    for index = 0, data:len(), ngx.ctx.max_chunk_size do
        chunk = string.sub(data, index, index + ngx.ctx.max_chunk_size - 1)
        local status, output, eof, bytes_in, bytes_out = pcall(stream, chunk)

        if not status then
            create_error_response(4001, "Corrupted GZIP body")
        end

        if bytes_in == 0 and bytes_out == 0 then
            -- body is not gzip compressed
            create_error_response(4002, "Invalid GZIP body")
        end

        buffer = buffer .. output

        if bytes_out > ngx.ctx.max_body_size then
            -- uncompressed body too large
            create_error_response(4003, "Uncompressed body too large")
        end
    end

    return buffer
end

return _Gzip