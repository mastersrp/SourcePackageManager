log = {
  file = ".spm/log",
  info = function(msg)
    local logfile = io.open(log.file, 'a+')
    logfile:write(os.date() .. ': info: ' .. tostring(msg) .. '\n')
    return logfile:close()
  end,
  warn = function(msg)
    local logfile = io.open(log.file, 'a+')
    logfile:write(os.date() .. ': warn: ' .. msg .. '\n')
    return logfile:close()
  end,
  erro = function(msg)
    local logfile = io.open(log.file, 'a+')
    logfile:write(os.date() .. ': erro: ' .. msg .. '\n')
    return logfile:close()
  end,
  debg = function(msg)
    if DEBUG then
      local logfile = io.open(log.file, 'a+')
      logfile:write(os.date() .. ': debg: ' .. msg .. '\n')
      return (function()
        local _base_0 = logfile
        local _fn_0 = _base_0.close
        return function(...)
          return _fn_0(_base_0, ...)
        end
      end)()
    end
  end
}
return log
