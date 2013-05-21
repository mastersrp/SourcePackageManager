require 'os'
require 'string'

io.exists = function( file )
	local err = io.open( file, "rb")
	if err == nil then return false else return true end
end

local conf = dofile('paklib/utils/conf.lua')
local deps,pkg = dofile( "Sourcefile" )

for k,_ in pairs(deps) do
	local v = deps[k]["url"] or ""
	if arg[1] == "pull" then
		if not io.exists( "deps/" .. k .. "/.git/config" ) then
			local domain, err
			err = os.execute("git ls-remote --head" .. v .. " &>/dev/null" )
			if err == nil then
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
			else
				domain = ""
			end
			os.execute( "git clone " .. domain .. v .. " deps/" .. v )
		end
	elseif arg[1] == "configure" then
		print( "* Configuring \"" .. k .. "\"..." )
		conf.update( 'DIR_' .. string.upper(k) .. '_ROOT', './deps/' .. v )
		conf.update( 'USE_' .. string.upper(k), 'y' )
		deps[k]["configure"]( "deps/" .. k )
	end
end
