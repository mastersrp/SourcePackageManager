local target = {}

if git == nil then
  require 'utils/git'
end

target.name = "clone"

target.execute = function( cfg )

  for k,_ in pairs(cfg[1]) do
    local repo = cfg[1][k]["url"]
    local url = nil
    local ret
    if io.exists( "./deps/" .. k .. "/.git/config" ) == false then
      local remotes = {"github.com"}
      for r,_ in pairs(remotes) do
        local repo = dofile '.spm/paklib/repo/' .. remotes[r] .. '.lua'
        local remote = string.gsub(repo.url,"%$(%w+)", cfg[1][k]["url"])
        ret = git.exists( remote )
        if ret == true then url = "git://" .. remotes[r] .. "/" .. repo end
      end
      if url == nil then return "missing url" end
      print( "* Cloning \"" .. k .."\" into \"./deps/" .. k .. "\"..." )
      ret = git.clone(url,repo)
      if ret ~= true then return "cloning failed" else return true end
    else
      print( "[i] Skipping \"" .. k .."\"... ")
    end
  end
end

return target
