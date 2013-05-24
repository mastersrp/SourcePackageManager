local target = {}

require 'log'

target.name = "build"

target.deps = {"configure"}

target.execute = function( cfg )
  print( "* Building everything..." )
  log.info( 'Building everything...' )
  local err
  if io.exists('.tup/db') == false then
    err = os.execute('tup init')
    if err ~= true then return "could not init tup database" end
  end
  err = os.execute('tup upd')
  if err ~= true then return "could not build targets!" end
  for k,_ in pairs(cfg["deps"]) do
    if cfg["deps"][k].build ~= nil then
      cfg["deps"][k].build(cfg)
    end
  end
  for k,_ in pairs(cfg["pkg"]) do
    if cfg["pkg"][k].build ~= nil then
      cfg["pkg"][k].build(cfg)
    end
  end
end

return target
