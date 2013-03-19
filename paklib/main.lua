tcc = {}

tcc.run = function( file, extra )
	if extra == nil then extra = "" end
	if DEBUG then
		io.output():write( "debug: $ CC-RUN " .. file .. "\n" )
	end
	os.execute('tcc -I.spm/paklib/include -L.spm/paklib/lib -lspm -B.spm/paklib/include ' .. extra .. ' -run ' .. file)
end

tcc.compile = function( files, cflags )
	if cflags == nil then cflags = "" end
	for _,file in ipairs(files) do
		if DEBUG then
			io.output():write( "debug: $ CC " .. file .. ".o\n" )
		end
		os.execute( 'tcc -I.spm/paklib/include -B.spm/paklib/include ' .. cflags .. ' -c ' .. file .. ' -o ' .. file .. '.o' )
	end
end

local c_scripts = {
	".spm/paklib/hello_world.c"
}

if DEBUG then
	tcc.compile( c_scripts,"-D_DEBUG_ -bench")
	tcc.run( ".spm/paklib/hello_world.c.o", "-D_DEBUG_ -bench " )
else
	tcc.compile( c_scripts,nil )
	tcc.run( ".spm/paklib/hello_world.c.o", nil )
end
