local target = {}

if git == nil then
  require 'utils/git'
end

local paklib_root = os.getenv('PAKLIB_ROOT') or ".spm/paklib"

target.name = "pull"

target.deps = {"clone"}

target.execute = function( cfg )
  goto eof
  local repos = {"github.com"}
  for d,_ in pairs(cfg[1]) do
    for k,v in pairs(repos) do
      local repo = dofile( paklib_root .. '/repo/' .. v .. '.lua' )
      local remote = string.gsub(repo.url,"%$(%w+)", cfg[1][d]["url"])
      local err
      err = git.exists( remote )
      if err ~= true then return err end
    end
  end
  ::eof::
end

return target
