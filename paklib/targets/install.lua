local target = {}

target.name = "install"

target.deps = {"build"}

target.execute = function( cfg )
  return true
end

return target
