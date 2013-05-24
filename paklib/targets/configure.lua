local target = {}

require 'utils/conf'
require 'log'

target.name = "configure"

target.deps = {"clone"}

target.execute = function( cfg )
  local err
  for k,_ in pairs(cfg["deps"]) do
    local repo = "./deps/" .. cfg["deps"][k]["url"]
    print( "* Configuring \"" .. k .. "\" ... " )
    log.info( 'Configuring "' .. k .. '"...' )
    conf.create( 'DIR_' .. string.upper(k) .. '_ROOT', repo )
    conf.create( 'USE_' .. string.upper(k), 'y' )
    if cfg["deps"][k].configure ~= nil then
      err = cfg["deps"][k].configure( repo )
      if err == nil then err = true end
      if err ~= true then return "could not configure \""..k.."\"!" end
    end
  end
  for k,_ in pairs(cfg["pkg"]) do
    if cfg["pkg"][k].configure ~= nil then
      print( "* Configuring \"" .. k .. "\" ... " )
      log.info( 'Configuring "' .. k .. '"...' )
      err = cfg["pkg"][k].configure( cfg )
      if err == nil then err = true end
      if err ~= true then return "could not configure \""..k.."\"!" end
    end
  end
  return true
end

return target
