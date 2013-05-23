log = {}

log.file = ".spm/log"

log._write = function(msg)
  local logfile = io.open(log.file,'a+')
  logfile:write(tostring(msg))
  return logfile:close()
end

log.info = function(msg)
  return log._write(os.date() .. ': info: ' .. msg .. '\n')
end

log.warn = function(msg)
  return log._write(os.date() .. ': warn: ' .. msg .. '\n')
end

log.erro = function(msg)
  return log._write(os.date() .. ': erro: ' .. msg .. '\n')
end

log.debg = function(msg)
  if DEBUG then
    return log._write(os.date() .. ': debg: ' .. msg .. '\n')
  end
end

return log
