#pragma once

#ifdef TE_PLATFORM_WINDOWS 
	#ifdef TE_BUILD_DLL
		#define TREELENGINE_API __declspec(dllexport)	
	#else
		#define TREELENGINE_API __declspec(dllexport)	
	#endif // TE_BUILD_DLL
#else
	#error Treel Engine only supports Windows
#endif // TE_PLATFORM_WINDOWS 
