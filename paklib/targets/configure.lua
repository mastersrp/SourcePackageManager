local target = {}

require 'utils/conf'
require 'log'

target.name = "configure"

target.deps = {"clone"}

target.execute = function( cfg )
  for k,_ in pairs(cfg["deps"]) do
    local repo = "./deps/" .. cfg["deps"][k]["url"]
    print( "* Configuring \"" .. k .. "\" ... " )
    log.info( 'Configuring "' .. k .. '"...' )
    conf.create( 'DIR_' .. string.upper(k) .. '_ROOT', repo )
    conf.create( 'USE_' .. string.upper(k), 'y' )
    if cfg["deps"][k].configure ~= nil then
      cfg["deps"][k].configure( repo )
    end
  end
  for k,_ in pairs(cfg["pkg"]) do
    if cfg["pkg"][k].configure ~= nil then
      print( "* Configuring \"" .. k .. "\" ... " )
      log.info( 'Configuring "' .. k .. '"...' )
      cfg["pkg"][k].configure( cfg )
    end
  end
  return true
end

return target
