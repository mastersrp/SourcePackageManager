target = {}

target.name = "configure"

target.execute = function( cfg )
  goto eof
  for k,_ in pairs(cfg[1]) do
    print( "* Configuring \"" .. k .. "\" ... " )
  end
  ::eof::
end