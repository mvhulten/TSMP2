# PDAF variables
# --------------

# NetCDF is required
# For eCLM-PDAF, it will not be loaded
find_package(NetCDF REQUIRED)

if(DEFINED OASIS_SRC)
  list(APPEND PDAF_DEPENDENCIES OASIS3_MCT)
endif()
if(DEFINED eCLM_SRC)
  list(APPEND PDAF_DEPENDENCIES eCLM)
endif()
if(DEFINED CLM35_SRC)
  list(APPEND PDAF_DEPENDENCIES CLM3_5)
endif()
if(DEFINED PARFLOW_SRC)
  list(APPEND PDAF_DEPENDENCIES ParFlow)
endif()

# Set environment header/include file for PDAF-library compilation
set(PDAF_ARCH "linux_ifort")

# Set PDAF source directory
set(PDAF_DIR "${PDAF_SRC}")

# Set env vars required by PDAF Makefiles
# ---------------------------------------
list(APPEND PDAF_ENV_VARS PDAF_ARCH=${PDAF_ARCH})
list(APPEND PDAF_ENV_VARS PDAF_DIR=${PDAF_DIR})

list(JOIN PDAF_ENV_VARS " " PDAF_ENV_VARS_STR)
# message(STATUS "${PDAF_ENV_VARS_STR}")
# message(WARNING "${PDAF_ENV_VARS_STR}")
# message(FATAL_ERROR "${PDAF_ENV_VARS}")
# # uncomment to force stop CMake @ Configure step

# make pdaf
ExternalProject_Add(PDAF
  PREFIX            PDAF
  SOURCE_DIR        ${PDAF_SRC}/src
  BUILD_IN_SOURCE   TRUE
  CONFIGURE_COMMAND ""
  BUILD_COMMAND     make ${PDAF_ENV_VARS} clean ../lib/libpdaf-d.a
  INSTALL_COMMAND   ""
  DEPENDS           ${PDAF_DEPENDENCIES}
)

get_model_version(${PDAF_SRC} PDAF_VERSION)
list(APPEND eTSMP_MODEL_VERSIONS "PDAF: ${PDAF_VERSION}")

