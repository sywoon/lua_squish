package.preload['global']=(function(...)function numbertostring(e)if e<0 then
return"-"..numbertostring(-e)end
if e<=10^13 then
return tostring(e)end
if math.modf(e)~=e then
return tostring(e)end
local n=math.fmod(e,10^13)local e=math.modf(e/10^13)local e=string.format("%s%013s",tostring(e),tostring(n))return e
end
end)package.preload['io_ext']=(function(...)function io.readFile(n,e)e=e or"r"local e=io.open(n,e)if e==nil then
return nil
end
local n=e:read("*a")e:close()return n
end
function io.writeFile(o,n,e)e=e or"w"local e=io.open(o,e)if e==nil then
return false
end
e:write(n)e:close()return true
end
function io.fileSize(e)local n=0
local e=io.open(e,"r")if e then
local o=e:seek()n=e:seek("end")e:seek("set",o)io.close(e)end
return n
end
end)require"global"require"io_ext"