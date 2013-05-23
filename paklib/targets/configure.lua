local target = {}

require 'utils/conf'

target.name = "configure"

target.deps = {"clone"}

target.execute = function( cfg )
  for k,_ in pairs(cfg[1]) do
    local repo = "./deps/" .. cfg[1][k]["url"]
    print( "* Configuring \"" .. k .. "\" ... " )
    conf.create( 'DIR_' .. string.upper(k) .. '_ROOT', repo )
    conf.create( 'USE_' .. string.upper(k), 'y' )
    if cfg[1][k].configure ~= nil then
      cfg[1][k].configure( repo )
    end
  end
  for k,_ in pairs(cfg[3]) do
    if cfg[3][k].configure ~= nil then
      print( "* Configuring \"" .. k .. "\" ... " )
      cfg[3][k].configure( cfg )
    end
  end
  return true
end

return target
