local target = {}

target.name = "clone"

target.execute = function( cfg )
  if git == nil then -- if git is not builtin
    -- revert to using system commands
    git = {}
    git.exists = function( remote )
      local err = os.execute( "git ls-remote --heads " .. remote .. " master" )
      if err == 0 then return true else return false end
    end
    git.clone = function( repo, url )
      return os.execute( "git clone " .. url .. " ./deps/" .. repo )
    end
  end
  for k,_ in pairs(cfg[1]) do
    local repo = cfg[1][k]["url"]
    local url = nil
    local ret
    if io.exists( "./deps/" .. k .. "/.git/config" ) == false then
      local remotes = {"github.com"}
      for r,_ in pairs(remotes) do
        ret = git.exists( "git://" .. remotes[r] .. "/" .. repo )
        if ret == true then url = "git://" .. remotes[r] .. "/" .. repo end
      end
      if type(url) == "nil" then return false end
      print( "* Cloning \"" .. k .."\" into \"./deps/" .. k .. "\"..." )
      ret = git.clone(url,repo)
      if ret ~= true then return false else return true end
    end
  end
end

return target
