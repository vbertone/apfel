# Set up swig
find_package(SWIG QUIET)
if (SWIG_FOUND)
   include(${SWIG_USE_FILE})

   # Include python
   cmake_policy(SET CMP0148 OLD)
   find_package(PythonLibs REQUIRED)
   include_directories(${PYTHON_INCLUDE_PATH})

   set(CMAKE_SWIG_FLAGS "")
   set_source_files_properties(${PROJECT_NAME}.i PROPERTIES CPLUSPLUS ON)
   include_directories(../include/)

   # Add swig module
   swig_add_library(apfel LANGUAGE python SOURCES ${PROJECT_NAME}.i)
   swig_link_libraries(apfel ${PROJECT_NAME} ${PYTHON_LIBRARIES})

   # Files to install with Python
   set(PYTHON_INSTALL_FILES
	     ${CMAKE_CURRENT_BINARY_DIR}/apfel.py
             ${CMAKE_CURRENT_BINARY_DIR}/_apfel.so)

   # Configure setup.py and copy to output directory
   set(SETUP_PY_IN ${CMAKE_CURRENT_SOURCE_DIR}/setup.py.in)
   set(SETUP_PY_OUT ${CMAKE_CURRENT_BINARY_DIR}/setup.py)
   configure_file(${SETUP_PY_IN} ${SETUP_PY_OUT})

   # Install target to call setup.py
   add_custom_target(install-python
	     DEPENDS _apfel
             COMMAND python ${SETUP_PY_OUT} install)

   find_package(Python3 REQUIRED)
   execute_process(COMMAND "${Python3_EXECUTABLE}" -c "import sysconfig; print('${CMAKE_INSTALL_PREFIX}' + sysconfig.get_path('purelib').replace(sysconfig.get_path('data'), ''), end = '')" OUTPUT_VARIABLE PYTHON_INSTALLATION_PATH)
   install(TARGETS _apfel LIBRARY DESTINATION "${PYTHON_INSTALLATION_PATH}")
else (SWIG_FOUND)
   message ("-- SWIG not found. The python wrapper will not be built.")
endif (SWIG_FOUND)
