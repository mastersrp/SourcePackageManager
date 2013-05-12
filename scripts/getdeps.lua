require 'os'
require 'string'

io.exists = function( file )
	local err = io.open( file, "rb")
	if err == nil then return false else return true end
end

dofile( "Sourcefile" )

for k,_ in pairs(deps) do
	local v = deps[k]["url"] or ""
	if not io.exists( "deps/"..v.."/.git/config" ) then
		local domain, err
		err = os.execute("git ls-remote --heads git://github.com/" .. v .. " &>/dev/null" )
		if err == nil then
			err = os.execute("git ls-remote --heads git://bitbucket.com/" .. v .. " &>/dev/null" )
			if err == nil then
				os.exit( 1 )
			else
				domain = "git://bitbucket.com/"
			end
		else
			domain = "git://github.com/"
		end
		os.execute( "git clone " .. domain .. v .. " deps/" .. k )
		print( "* Configuring \"" .. k .. "\"..." )
		deps[k]["configure"]( "deps/" .. k )
		io.open("build/tup.config","a"):write("CONFIG_DIR_" .. string.upper(k) .. "_ROOT=./deps/" .. k .. "\n" )
		io.open("build/tup.config","a"):write("CONFIG_USE_" .. string.upper(k) .. "=y \n")
	end
end
