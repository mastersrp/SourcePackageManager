conf = {}

conf.update = function(key,var,confile)
  if confile == nil then confile = "build/tup.config" end
  key = string.upper(key)
  key = "CONFIG_" .. key
  local f = io.open(confile,'rb')
  local t = {}
  local out
  local config = ""
  if f ~= nil then 
    f = f:read('*a')
    for k,v in string.gmatch(f,"(%g+)=(%S+)") do
      t[k] = v
    end
  end
  t[key] = var
  f = io.open(confile,'w+b')
  f:flush()
  f:close()-- all data is now in memory only
  local out = io.open(confile,'a+b')
  for k,v in pairs(t) do
    config = config .. k .. '=' .. v
    if string.sub(v,-1) ~= "\n" then config = config .. "\n" end
  end
  out:write(config) -- write the entire configuration at once to conserve writes to disk
  out:close()
end

conf.get = function(key, confile)
  if confile == nil then confile = "build/tup.config" end
  key = string.upper(key)
  key = "CONFIG_" .. key
  local f = io.open(confile,'rb')
  local t = {}
  if f == nil then return "could not open config file" end
  f = f:read('*a')
  for k,v in string.gmatch(f,"(%g+)=(%S+)") do
    t[k] = v
  end
  if t[key] == nil then return false else return t[key] end
end

return conf
