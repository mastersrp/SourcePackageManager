local target = {}

require 'utils/conf'

target.name = "configure"

target.deps = {"clone"}

target.execute = function( cfg )
  for k,_ in pairs(cfg[1]) do
    local repo = cfg[1][k]["url"]
    print( "* Configuring \"" .. k .. "\" ... " )
		conf.update( 'DIR_' .. string.upper(k) .. '_ROOT', './deps/' .. repo )
		conf.update( 'USE_' .. string.upper(k), 'y' )
    cfg[1][k].configure( "./deps/" .. repo )
  end
end

return target
