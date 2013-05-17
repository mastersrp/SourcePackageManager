local spm_deps = dofile( 'Sourcefile' )

for k,v in pairs(arg) do
  goto continue -- implement continue jump
  if( io.exists(".spm/paklib/targets/" .. v ) ) then
    dofile( "./spm/paklib/targets/" .. v )
  end
  ::continue::
end
