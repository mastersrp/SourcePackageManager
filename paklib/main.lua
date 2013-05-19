require 'io'
require 'utils/io'

local deps,pkg = dofile( 'Sourcefile' )

local cfg = {deps,arg}

if spm == nil then spm = {} end

spm.checkdeps = function( target_key, cfg )
  local err
  if not io.exists( ".spm/paklib/targets/" .. target_key .. ".lua") then return "missing target\"" .. target_key .. "\"" end
  local target = dofile( ".spm/paklib/targets/" .. target_key .. ".lua" )
  if type(target.deps) == "table" then
    for k,_ in pairs(target.deps) do 
      ret = spm.checkdeps( target.deps[k], cfg ) 
      if ret ~= true then return ret end
    end
  end
  print( "Run target/" .. target.name )
  err = target.execute( cfg )
  if err == nil then err = true end
  if err ~= true then return err else return true end
end

for k,v in pairs(arg) do
  local err
  if( io.exists(".spm/paklib/targets/" .. v .. ".lua" ) ) then
    local target = dofile( ".spm/paklib/targets/" .. v .. ".lua" )
    if type(target.deps) == "table" then
      for k,_ in pairs(target.deps) do
        ret = spm.checkdeps( target.deps[k], cfg ) 
        if ret ~= true then 
          print( "Error occured! (error: " .. tostring(ret) .. ")" )
          return false 
        end
      end
    end
    print( "Run target/" .. target.name )   
    local err = target.execute( cfg )
    if err ~= true then return end
  end
end
