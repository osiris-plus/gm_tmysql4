-- bjam release address-model=32 runtime-link=static --with-system --with-thread --with-date_time --with-regex --with-serialization stage

local osname = os.target()
local dllname = osname

if dllname == "windows" then
	dllname = "win32"
end

solution "tmysql4"
	language "C++"
	location ( osname .."-".. _ACTION )
	symbols "On"
	editandcontinue "Off"
	vectorextensions "SSE"
	flags {"NoPCH", "StaticRuntime"}
	targetdir ( "bin/" .. osname .. "/" )
	includedirs { "include/GarrysMod", "include/" .. osname, "include/boost" }
	platforms{ "x32" }
	libdirs { "library/" .. osname }

	targetprefix ("gmsv_")
	targetname(solution().name)
	targetsuffix("_" .. dllname)
	targetextension ".dll"

	if osname == "windows" then
		links { "mysqlclient" }
	elseif osname == "linux" then
		links { "mysqlclient", "boost_system", "rt" }
	else error( "unknown os: " .. osname ) end
	
	configurations
	{ 
		"Release"
	}
	
	configuration "Release"
		optimize "On"
		floatingpoint "Fast"
		if osname == "linux" then
			buildoptions { "-std=c++0x -pthread -Wl,-z,defs" }
		end
		defines { "NDEBUG" }
	
	project "tmysql4"
		defines { "GMMODULE", "ENABLE_QUERY_TIMERS" }
		files { "src/**.*", "include/**.*" }
		kind "SharedLib"
		