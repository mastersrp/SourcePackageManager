local target = {}

require 'log'
require 'utils/sh'

target.name = "build"

target.deps = {"configure"}

target.execute = function( cfg )
  print( "* Building everything..." )
  log.info( 'Building everything...' )
  local err
  if io.exists('.tup/db') == false then
    err = sh 'tup init'
    if err ~= true then return "could not init tup database" end
  end
  err = sh 'tup upd'
  if err ~= true then return "could not build targets!" end
  for k,_ in pairs(cfg["deps"]) do
    if cfg["deps"][k].build ~= nil then
      local repo = "./deps/" .. cfg["deps"][k]["url"]
      cfg["deps"][k].build( repo )
    end
  end
  for k,_ in pairs(cfg["pkg"]) do
    if cfg["pkg"][k].build ~= nil then
      cfg["pkg"][k].build(cfg)
    end
  end
  return true
end

return target
