
// mydll.hpp
#ifdef __cplusplus
extern "C" {
#endif

#ifdef BUILD_DLL
    #define DLL_EXPORT __declspec(dllexport)
#else
    #define DLL_EXPORT __declspec(dllimport)
#endif

    DLL_EXPORT void MyFunction();

#ifdef __cplusplus
}
#endif

#ifdef IMPLEMENTATION 
#include <iostream>

void MyFunction() {
    std::cout << "Hello from DLL!" << std::endl;
}
#endif
