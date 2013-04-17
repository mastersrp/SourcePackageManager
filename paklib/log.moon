export log
log =
	file: ".spm/log"
	info: (msg) ->
		logfile = io.open log.file, 'a+'
		logfile\write os.date! .. ': info: ' .. tostring(msg) .. '\n'
		logfile\close!
	warn: (msg) ->
		logfile = io.open log.file, 'a+'
		logfile\write os.date! .. ': warn: ' .. msg .. '\n'
		logfile\close!
	erro: (msg) ->
		logfile = io.open log.file, 'a+'
		logfile\write os.date! .. ': erro: ' .. msg .. '\n'
		logfile\close!
	debg: (msg) ->
		if DEBUG
			logfile = io.open log.file, 'a+'
			logfile\write os.date! .. ': debg: ' .. msg .. '\n'
			logfile\close

log
