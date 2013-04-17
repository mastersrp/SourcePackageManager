require 'log'
export tcc
tcc =
	run: (file,extra) ->
		if extra == nil
			extra = ""
		log.debg "debug: $ CC-RUN " .. file
		os.execute 'tcc -I.spm/paklib/include -L.spm/paklib/lib -lspm -B.spm/paklib/include ' .. extra .. ' -run ' .. file

	compile: (file,cflags) ->
		if cflags == nil
			cflags = ""
		for _,v in pairs file do
			log.debg "debug: $ CC " .. tostring(v) .. ".o"
			os.execute 'tcc -I.spm/paklib/include -B.spm/paklib/include ' .. tostring(cflags) .. ' -c ' .. v .. ' -o ' .. v .. '.o'

tcc
