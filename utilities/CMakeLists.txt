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
target_compile_definitions(magick PRIVATE ${MAGICK_BUILD_DEFINES})
target_link_libraries(magick PRIVATE MagickWand)

install(TARGETS magick
  RUNTIME DESTINATION bin
  BUNDLE DESTINATION bin
)
