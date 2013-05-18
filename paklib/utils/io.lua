if io.exists == nil then 
  io.exists = function( file )
  if io.open(file,'rb') == nil then return false else return true end
  end
end
