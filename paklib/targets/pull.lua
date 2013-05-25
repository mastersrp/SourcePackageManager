local target = {}

if git == nil then
  require 'utils/git'
end

require 'utils/conf'
require 'log'

local paklib_root = os.getenv('PAKLIB_ROOT') or ".spm/paklib"

target.name = "pull"

target.deps = {"clone"}

target.execute = function( cfg )
  local repos = {"github.com"}
  for d,_ in pairs(cfg["deps"]) do
    for k,v in pairs(repos) do
      local repo = dofile( paklib_root .. '/repo/' .. v .. '.lua' )
      local remote = string.gsub(repo.url,"%$(%w+)", cfg["deps"][d]["url"])
      local err
      print( "* Pulling in \"./deps/" .. cfg["deps"][d]["url"] .. "\"..." )
      log.info( "* Pulling in \"./deps/" .. cfg["deps"][d]["url"] .. "\"..." )
      err = git.exists( remote )
      if err ~= true then return err end     
      err = git.pull( "./deps/" .. cfg["deps"][d]["url"] )
      if err ~= true then return err end
    end
  end
  return true
end

return target
