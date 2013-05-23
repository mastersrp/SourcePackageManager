local target = {}

target.name = "build"

target.deps = {"configure"}

target.execute = function( cfg )
  print( "* Building everything..." )
  local err
  if io.exists('.tup/db') == false then
    err = os.execute('tup init')
    if err ~= true then return "could not init tup database" end
  end
  err = os.execute('tup upd')
  if err ~= true then return "could not build targets!" else return true end
end

return target
