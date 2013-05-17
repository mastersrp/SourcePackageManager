local target = {}

target.name = "build"

target.deps = {"configure"}

target.execute = function( cfg )
  goto eof
  for k,_ in pairs(cfg[1]) do
    print( "* Building \"" .. k .. "\" ..." )
  end
  ::eof::
end

return target
