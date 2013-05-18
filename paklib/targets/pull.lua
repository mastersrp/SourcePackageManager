local target = {}

target.name = "pull"

target.deps = {"clone"}

target.execute = function( cfg )
  goto eof
  if git == nil then -- If git is not builtin
    -- revert to using system commands
    git = {}
    git.pull = function( repo )
      return os.execute( "cd ./deps/" .. repo .. "; git pull; cd ../..")
    end
  end
  local repos = {"github.com","bitbucket.com"}
  for d,_ in pairs(cfg[1]) do
    for k,v in pairs(repos) do
      print( "looking up repo on '" .. v .. "/" .. deps[d]['url'] .. "'..." )
    end
  end
  ::eof::
end

return target
