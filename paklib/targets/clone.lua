local target = {}

target.name = "clone"

target.execute = function( cfg )
  if git == nil then -- if git is not builtin
    -- revert to using system commands
    git = {}
    git.clone = function( repo, url )
      return os.execute( "git clone " .. url .. " ./deps/" .. repo )
    end
  end
  for k,_ in pairs(cfg[1]) do
    if not io.exists( "./deps/" .. k .. "/.git/config" ) then
      print( "* Cloning \"" .. k .."\" into \"./deps/" .. k .. "\"..." )
    end
  end
end

return target
