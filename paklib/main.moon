tcc =
	run: (file,extra) ->
	compile: (file,cflags) ->

tcc.run =  (file,extra) ->
	if extra == nil
		extra = ""
	if DEBUG
		print "debug: $ CC-RUN " .. file
	os\execute 'tcc -I.spm/paklib/include -L.spm/paklib/lib -lspm -B.spm/paklib/include ' .. extra .. ' -run ' .. file

tcc.compile = (file,cflags) ->
	if cflags == nil
		cflags = ""
	if DEBUG
		print "debug: $ CC " .. file .. ".o"
	os\execute 'tcc -I.spm/paklib/include -B.spm/paklib/include ' .. tostring(cflags) .. ' -c ' .. file .. ' -o ' .. file .. '.o'

c_scripts = {
	".spm/paklib/hello_world.c"
}

if DEBUG
	tcc\compile c_scripts, '-D_DEBUG_ -bench'
	tcc\run ".spm/paklib/hello_world.c.o", "-D_DEBUG_ -bench"
else
	tcc\compile c_scripts, nil
	tcc\run ".spm/paklib/hello_world.c.o", nil
