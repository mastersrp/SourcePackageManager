build = {}

build.types = {
	["auto"] = function()
		io:write( "Autodetecting build system" )
	end,["autogen"] = function()
		io:write( "Using autogen to configure package" )
	end,["configure"] = function()
		io:write( "Using ./configure to configure package" )
	end,["cmake"] = function()
		io:write( "Using cmake to configure package" )
	end,["make"] = function()
		io:write( "Using make to build package, no configuring done" )
	end}

build.configure = function(buildtype)
	if( build.types[buildtype] == nil ) then
		return nil
	else
		return build.types[buildtype]()
	end
end

build.build = function()
end
