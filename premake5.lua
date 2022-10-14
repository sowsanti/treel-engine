workspace "treel-engine"
	architecture "x64"

	configurations {
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "treel-engine"
	location "treel-engine"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("int/" .. outputdir .. "/%{prj.name}")

	files {
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs {
		"%{prj.name}/vendor/spdlog/include"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines {
			"TE_PLATFORM_WINDOWS",
			"TE_BUILD_DLL"
		}

		postbuildcommands {
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/sandbox")
		}

	filter "configurations:Debug"
		defines "TE_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "TE_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "TE_DIST"
		optimize "On"

project "sandbox"
	location "sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("int/" .. outputdir .. "/%{prj.name}")

	files {
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs {
		"treel-engine/vendor/spdlog/include",
		"treel-engine/src",
	}

	links {
		"treel-engine"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines {
			"TE_PLATFORM_WINDOWS",
		}

	filter "configurations:Debug"
		defines "TE_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "TE_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "TE_DIST"
		optimize "On"