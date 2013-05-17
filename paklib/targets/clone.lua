target = {}

target.name = "clone"

target.execute = function( cfg )
  for k,_ in pairs(cfg[1]) do
    if not io.exists( "./deps/" .. k .. "/.git/config" ) then
      print( "* Cloning \"" .. k .."\" into \"./deps/" .. k .. "\"..." )
    end
  end
end
