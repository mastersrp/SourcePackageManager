tcc = {}

tcc.run = function( file )
	os.execute( "tcc -L.spm/paklib -I.spm/paklib/include -lspm -nostdinc -B.spm/paklib/include -run " .. file )
end
