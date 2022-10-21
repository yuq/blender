# SPDX-License-Identifier: BSD-3-Clause
# Copyright 2022 Blender Foundation.

# - Find Vulkan library
# Find the native USD includes and libraries
# This module defines
#  VULKAN_INCLUDE_DIRS, where to find Vulkan headers.
#  VULKAN_LIBRARIES, libraries to link against to use USD.
#  VULKAN_ROOT_DIR, The base directory to search for USD.
#                    This can also be an environment variable.
#  VULKAN_FOUND, If false, do not try to use USD.
#

# If VULKAN_ROOT_DIR was defined in the environment, use it.
IF(NOT VULKAN_ROOT_DIR AND NOT $ENV{VULKAN_ROOT_DIR} STREQUAL "")
 SET(VULKAN_ROOT_DIR $ENV{VULKAN_ROOT_DIR})
ENDIF()

SET(_vulkan_SEARCH_DIRS
  ${VULKAN_ROOT_DIR}
)

FIND_PATH(VULKAN_INCLUDE_DIR
  NAMES
    MoltenVK/vk_mvk_moltenvk.h
    
  HINTS
    ${_vulkan_SEARCH_DIRS}/MoltenVK/
  PATH_SUFFIXES
    include
  DOC "MoltenVK header files"
)

FIND_LIBRARY(VULKAN_LIBRARY
  NAMES
    MoltenVK
  NAMES_PER_DIR
  HINTS
    ${_vulkan_SEARCH_DIRS}/MoltenVK/dylib/
  PATH_SUFFIXES
    macOS
  DOC "MolkenVK MacOS Vulkan translation layer library"
)

IF(${VULKAN_LIBRARY_NOTFOUND})
  SET(VULKAN_FOUND FALSE)
ELSE()
  INCLUDE(FindPackageHandleStandardArgs)
  FIND_PACKAGE_HANDLE_STANDARD_ARGS(VULKAN DEFAULT_MSG VULKAN_LIBRARY VULKAN_INCLUDE_DIR)

  IF(VULKAN_FOUND)
    SET(VULKAN_INCLUDE_DIRS ${VULKAN_INCLUDE_DIR})
    SET(VULKAN_LIBRARIES ${VULKAN_LIBRARY})
  ENDIF()

ENDIF()

MARK_AS_ADVANCED(
  VULKAN_INCLUDE_DIR
  VULKAN_LIBRARY
)

UNSET(_vulkan_SEARCH_DIRS)