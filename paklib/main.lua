dofile( 'Sourcefile' )

local cfg = {deps,arg}

io.exists = function( file )
  local f = io.open( file, 'rb' )
  if f == nil then return false else return true end
end

if spm == nil then spm = {} end

spm.checkdeps = function( target_key, cfg )
  if not io.exists( ".spm/paklib/targets/" .. target_key .. ".lua") then return false end
  local target = dofile( ".spm/paklib/targets/" .. target_key .. ".lua" )
  if type(target.deps) == "table" then
    for k,_ in pairs(target.deps) do spm.checkdeps( target.deps[k], cfg ) end
  end
  print( "Run target/" .. target.name )
  target.execute( cfg )
  return true
end

for k,v in pairs(arg) do
  if( io.exists(".spm/paklib/targets/" .. v .. ".lua" ) ) then
    local target = dofile( ".spm/paklib/targets/" .. v .. ".lua" )
    if type(target.deps) == "table" then
      for k,_ in pairs(target.deps) do spm.checkdeps( target.deps[k], cfg ) end
    end
     print( "Run target/" .. target.name )   
     target.execute( cfg )
  end
end
