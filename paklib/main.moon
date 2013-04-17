require 'tcc'

c_scripts = {
	".spm/paklib/hello_world.c"
}

if DEBUG
	tcc.compile c_scripts, '-D_DEBUG_ -bench'
	tcc.run ".spm/paklib/hello_world.c.o", "-D_DEBUG_ -bench"
else
	tcc.compile c_scripts, nil
	tcc.run ".spm/paklib/hello_world.c.o", nil
