local target = {}

if git == nil then
  require 'utils/git'
end

target.name = "pull"

target.deps = {"clone"}

target.execute = function( cfg )
  goto eof
  local repos = {"github.com"}
  for d,_ in pairs(cfg[1]) do
    for k,v in pairs(repos) do
      local repo = dofile '.spm/paklib/repo/' .. v .. '.lua'
      local remote = string.gsub(repo.url,"%$(%w+)", cfg[1][d]["url"])
      local err
      err = git.exists( remote )
      if err ~= true then return err end
    end
  end
  ::eof::
end

return target
