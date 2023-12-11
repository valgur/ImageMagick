#   Licensed under the ImageMagick License (the "License"); you may not use
#   this file except in compliance with the License.  You may obtain a copy
#   of the License at
#
#     https://imagemagick.org/script/license.php
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#   WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
#   License for the specific language governing permissions and limitations
#   under the License.
#
#   CMake script file to build ImageMagick
#

set(MAGICK_SRC
  magick.c
)

add_executable(magick ${MAGICK_SRC} ${MAGICK_RESOURCE_FILE_PATH})

target_include_directories(magick PRIVATE ${IMAGEMAGICK_BASE_PATH})
target_link_libraries(magick PRIVATE MagickWand)

set(MAGICK_LINKED_UTILITIES animate compare composite conjure convert display identify import magick-script mogrify montage stream)
foreach(utility ${MAGICK_LINKED_UTILITIES})
  add_custom_command(TARGET magick POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E create_symlink magick ${utility}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  )
endforeach()

install(TARGETS magick
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  BUNDLE DESTINATION ${CMAKE_INSTALL_BINDIR}
)
foreach(utility ${MAGICK_LINKED_UTILITIES})
  install(CODE "execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink magick \${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_BINDIR}/${utility})")
  list(APPEND BINARY_DIR_SYMLINKS ${CMAKE_CURRENT_BINARY_DIR}/${utility})
endforeach()

set_property(DIRECTORY PROPERTY ADDITIONAL_CLEAN_FILES "${BINARY_DIR_SYMLINKS}")
