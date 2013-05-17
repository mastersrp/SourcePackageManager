target = {}

target.name = "build"

target.execute = function( cfg )
  goto eof
  for k,_ in pairs(cfg[1]) do
    print( "* Building \"" .. k .. "\" ..." )
  end
  ::eof::
end
