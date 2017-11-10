local BasePlugin = require "kong.plugins.base_plugin"
local HostTokenRouter = BasePlugin:extend()

-- Constructor
function HostTokenRouter:new()
  HostTokenRouter.super.new(self, "host-token")
end

function HostTokenRouter:access(config)
  HostTokenRouter.super.access(self)

  if config.route_on_token then
    local upstream_host = string.format("%s.example.org", ngx.var.arg_token)
    ngx.ctx.balancer_address.host = upstream_host
  end
end

-- This module needs to return the created table, so that Kong
-- can execute those functions.
return HostTokenRouter