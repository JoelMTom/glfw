---@diagnostic disable: undefined-global, undefined-field

local projectName = path.getbasename(os.getcwd())

project (projectName)
  kind "StaticLib"
  language "C"

	targetdir ("%{wks.location}/bin/" .. Outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. Outputdir .. "/%{prj.name}")

  files {
    "include/**.h",
    "src/**.h",
    "src/**.c",
  }

  IncludedirsDep[projectName] = os.getcwd() .. "/include/"
  Linklib[projectName] = projectName

  filter "system:linux"
    defines "_GNU_SOURCE"

    removefiles {
      "src/cocoa*",
      "src/win32*",
      "src/wgl*"
      -- "src/cocoa_time.c",
    }

  filter "options:display-server=x11"
    defines "_GLFW_X11"
    removefiles {
      "src/wl*",
    }

  filter "options:display-server=wayland"
    defines "_GLFW_WAYLAND"
    removefiles {
      "src/x11*"
    }

  filter {}

