local target = {}

if git == nil then
  require 'utils/git'
end

target.name = "pull"

target.deps = {"clone"}

target.execute = function( cfg )
  local repos = {"github.com"}
  for d,_ in pairs(cfg[1]) do
    for k,v in pairs(repos) do
      print( "looking up repo on '" .. v .. "/" .. deps[d]['url'] .. "'..." )
    end
  end
end

return target
