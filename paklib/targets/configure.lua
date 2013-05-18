local target = {}

target.name = "configure"

target.deps = {"clone"}

target.execute = function( cfg )
  for k,_ in pairs(cfg[1]) do
    print( "* Configuring \"" .. k .. "\" ... " )
    cfg[1][k].configure( "./deps/" .. k )
  end
end

return target
