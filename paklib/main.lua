dofile( 'Sourcefile' )

local cfg = {deps,arg}

io.exists = function( file )
  local f = io.open( file, 'rb' )
  if f == nil then return false else return true end
end

for k,v in pairs(arg) do
  if( io.exists(".spm/paklib/targets/" .. v .. ".lua" ) ) then
    dofile( ".spm/paklib/targets/" .. v .. ".lua" )
    print( "Run target/" .. target.name )
    target.execute( cfg )
  end
end
