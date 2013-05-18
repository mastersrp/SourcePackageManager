local target = {}

target.name = "build"

target.deps = {"configure"}

target.execute = function( cfg )
  print( "* Building everything..." )
  local err
  if io.exists('.tup/db') == false then
    err = os.execute('.spm/bin/tup init')
    if err ~= 0 then return false end
  end
  err = os.execute('.spm/bin/tup upd')
  if err ~= 0 then return false else return true end
end

return target
