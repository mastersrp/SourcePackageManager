sh = function( cmd )
  return os.execute( os.getenv('SHELL') .. " -c \"" .. cmd .. "\"" )
end
return sh
