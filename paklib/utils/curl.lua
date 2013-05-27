if curl == nil then
  curl = {}
  curl.fetch = function(src,dest)
    sh( 'curl --create-dirs -L ' .. src .. ' > ' .. dest )
  end
end
