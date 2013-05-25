if git == nil then -- if git isn't built in
  git = {} -- we create it using system commands

  git.exists = function( remote )
    local err = os.execute( "git ls-remote --heads " .. remote .. " master" )
    if err == true then return true else return "no remotes found" end
  end
  git.clone = function( remote, lokal )
    local err = os.execute( "git clone " .. remote .. " " .. lokal )
    if err == true then return true else return "cloning failed!" end
  end
  git.pull = function( repo )
    local err = os.execute( "cd " .. repo .. "; git pull;")
    if err == true then return true else return "could not pull in \"" .. repo .. "\"" end
  end
  
  return git
end
