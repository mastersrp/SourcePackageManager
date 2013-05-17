target = {}

target.name = "pull"

target.execute = function( cfg )
  goto eof
  local repos = {"github.com","bitbucket.com"}
  for d,_ in pairs(cfg[1]) do
    for k,v in pairs(repos) do
      print( "looking up repo on '" .. v .. "/" .. deps[d]['url'] .. "'..." )
    end
  end
  ::eof::
end
