package.path = "./?/init.lua;".. package.path 
local vstruct = require"vstruct"
local inf = math.huge

-- work around a bug in the Lua constant table optimizer
local z = 0
local nz = -z

function to_hex(bytes, sep)
   local hexes = {}
   local append = table.insert
   for b in bytes:gmatch"." do
      append(hexes, ("%02x"):format(b:byte()))
   end
   return table.concat(hexes, sep)
end

function test(num, bytes)
   local packed_bytes = vstruct.pack("> f8", { num })
   local status = packed_bytes == bytes and "PASS" or "FAIL"

   io.write(("%s   packing %-30.20g"):format(status, num))
   if status == "FAIL" then
      io.write(("\twanted %-30s got %-30s"):format(
		  to_hex(bytes), to_hex(packed_bytes)))
   end
   io.write"\n"

   local unpacked_num = unpack((assert(vstruct.unpack("> f8", bytes))))
   local status = unpacked_num == num and "PASS" or "FAIL"

   io.write(("%s unpacking %-30s"):format(status, to_hex(bytes)))
   if status == "FAIL" then
      io.write(("\twanted %-30.20g got %-30.20g"):format(
		  num, unpacked_num))
   end
   io.write"\n"
end

test(0, "\000\000\000\000\000\000\000\000")
test(4.9406564584124654418e-324, "\000\000\000\000\000\000\000\001")
test(7.4169128616906696301e-309, "\000\005\085\085\085\085\085\085")
test(1.483382572338133926e-308, "\000\010\170\170\170\170\170\170")
test(2.225073858507200889e-308, "\000\015\255\255\255\255\255\255")
test(2.2250738585072013831e-308, "\000\016\000\000\000\000\000\000")
test(2.2250738585072018772e-308, "\000\016\000\000\000\000\000\001")
test(2.9667651446762683461e-308, "\000\021\085\085\085\085\085\085")
test(3.7084564308453353091e-308, "\000\026\170\170\170\170\170\170")
test(4.4501477170144022721e-308, "\000\031\255\255\255\255\255\255")
test(8.9884656743115795386e+307, "\127\224\000\000\000\000\000\000")
test(8.9884656743115815345e+307, "\127\224\000\000\000\000\000\001")
test(1.1984620899082105386e+308, "\127\229\085\085\085\085\085\085")
test(1.4980776123852631234e+308, "\127\234\170\170\170\170\170\170")
test(1.7976931348623157081e+308, "\127\239\255\255\255\255\255\255")
test(4.9406564584124654418e-324, "\000\000\000\000\000\000\000\001")
test(2.225073858507200889e-308, "\000\015\255\255\255\255\255\255")
test(2.2250738585072013831e-308, "\000\016\000\000\000\000\000\000")
test(1.7976931348623157081e+308, "\127\239\255\255\255\255\255\255")
test(inf, "\127\240\000\000\000\000\000\000")
test(0, "\000\000\000\000\000\000\000\000")
test(nz, "\128\000\000\000\000\000\000\000")
test(-4.9406564584124654418e-324, "\128\000\000\000\000\000\000\001")
test(-7.4169128616906696301e-309, "\128\005\085\085\085\085\085\085")
test(-1.483382572338133926e-308, "\128\010\170\170\170\170\170\170")
test(-2.225073858507200889e-308, "\128\015\255\255\255\255\255\255")
test(-2.2250738585072013831e-308, "\128\016\000\000\000\000\000\000")
test(-2.2250738585072018772e-308, "\128\016\000\000\000\000\000\001")
test(-2.9667651446762683461e-308, "\128\021\085\085\085\085\085\085")
test(-3.7084564308453353091e-308, "\128\026\170\170\170\170\170\170")
test(-4.4501477170144022721e-308, "\128\031\255\255\255\255\255\255")
test(-8.9884656743115795386e+307, "\255\224\000\000\000\000\000\000")
test(-8.9884656743115815345e+307, "\255\224\000\000\000\000\000\001")
test(-1.1984620899082105386e+308, "\255\229\085\085\085\085\085\085")
test(-1.4980776123852631234e+308, "\255\234\170\170\170\170\170\170")
test(-1.7976931348623157081e+308, "\255\239\255\255\255\255\255\255")
test(-4.9406564584124654418e-324, "\128\000\000\000\000\000\000\001")
test(-2.225073858507200889e-308, "\128\015\255\255\255\255\255\255")
test(-2.2250738585072013831e-308, "\128\016\000\000\000\000\000\000")
test(-1.7976931348623157081e+308, "\255\239\255\255\255\255\255\255")
test(-inf, "\255\240\000\000\000\000\000\000")
test(nz, "\128\000\000\000\000\000\000\000")
