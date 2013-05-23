local target = {}

if git == nil then
  require 'utils/git'
end
require 'utils/conf'
require 'log'

local paklib_root = os.getenv('PAKLIB_ROOT') or ".spm/paklib"

target.name = "clone"

target.execute = function( cfg )
  for k,_ in pairs(cfg[1]) do
    local repo = cfg[1][k]["url"]
    local url = nil
    local ret
    if io.exists( "./deps/" .. repo .. "/.git/config" ) == false then
      local remotes = {"github.com"}
      for r,_ in pairs(remotes) do
        local repo = dofile( paklib_root .. '/repo/' .. remotes[r] .. '.lua' )
        local remote = string.gsub(repo.url,"%$(%w+)", cfg[1][k]["url"])
        ret = git.exists( remote )
        if ret == true then url = remote end
      end
      if url == nil then return "missing url" end
      print( "* Cloning \"" .. k .."\" into \"./deps/" .. repo .. "\"..." )
      log.info( 'Cloninig "' .. k .. '" info "./deps/' .. repo .. '"...' )
      ret = git.clone(url, './deps/' .. repo)
      if ret ~= true then 
        return "cloning failed" 
      else 
        conf.create( 'DIR_' .. string.upper(k) .. '_ROOT', './deps/' .. repo )
      end
    else
      print( "[i] Skipping \"" .. k .."\"... ")
      log.info( 'Skipping "' .. k .. '"...' )
    end
  end

  return true
end

return target
