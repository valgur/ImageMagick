# Copyright 1999 ImageMagick Studio LLC, a non-profit organization
# dedicated to making software imaging solutions freely available.
#
# You may not use this file except in compliance with the License.
# obtain a copy of the License at
#
#   https://imagemagick.org/script/license.php
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#  CMakeLists.txt for the ImageMagick validation suite.

add_executable(validate validate.c)
target_link_libraries(validate PRIVATE MagickCore MagickWand)
add_executable(drawtest drawtest.c)
target_link_libraries(drawtest PRIVATE MagickCore MagickWand)
add_executable(wandtest wandtest.c)
target_link_libraries(wandtest PRIVATE MagickCore MagickWand)

enable_testing()

set(TEST_ENV
    "CONVERT=${CMAKE_BINARY_DIR}/utilities/magick"
    "IDENTIFY=${CMAKE_BINARY_DIR}/utilities/magick"
    "VALIDATE=${CMAKE_BINARY_DIR}/tests/validate"
    "DRAWTEST=${CMAKE_BINARY_DIR}/tests/drawtest"
    "WANDTEST=${CMAKE_BINARY_DIR}/tests/wandtest"
    "SRCDIR=${CMAKE_CURRENT_BINARY_DIR}"
    "srcdir=${CMAKE_CURRENT_BINARY_DIR}"
    "TOPSRCDIR=${CMAKE_SOURCE_DIR}"
    "REFERENCE_IMAGE=${CMAKE_SOURCE_DIR}/images/rose.pnm"
)

macro(add_tap_test TEST_NAME)
  add_test(
      NAME ${TEST_NAME}
      COMMAND sh -c "sh ${TEST_NAME}.tap | tee /dev/fd/2 | grep -q 'not ok' && exit 1 || exit 0"
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  )
  set_tests_properties(${TEST_NAME} PROPERTIES ENVIRONMENT "${TEST_ENV}")
endmacro()

add_tap_test(validate-colorspace)
add_tap_test(validate-compare)
add_tap_test(validate-composite)
add_tap_test(validate-convert)
add_tap_test(validate-formats-disk)
add_tap_test(validate-formats-map)
add_tap_test(validate-formats-memory)
add_tap_test(validate-identify)
add_tap_test(validate-import)
add_tap_test(validate-magick)
add_tap_test(validate-montage)
add_tap_test(validate-stream)
add_tap_test(cli-colorspace)
add_tap_test(cli-pipe)
add_tap_test(drawtest)
add_tap_test(wandtest)

add_custom_target(copy_test_resources ALL)
file(GLOB TEST_RESOURCES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.tap *.miff *.pnm)
foreach(TEST_RESOURCE ${TEST_RESOURCES})
  set(SRC ${CMAKE_CURRENT_SOURCE_DIR}/${TEST_RESOURCE})
  set(DST ${CMAKE_CURRENT_BINARY_DIR}/${TEST_RESOURCE})
  add_custom_command(
      OUTPUT ${DST}
      COMMAND ${CMAKE_COMMAND} -E copy_if_different ${SRC} ${DST}
      DEPENDS ${SRC}
  )
  add_custom_target(copy_${TEST_RESOURCE} ALL DEPENDS ${SRC} ${DST})
  add_dependencies(copy_test_resources copy_${TEST_RESOURCE})
endforeach()

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/common.shi "")
file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/tests/common.shi "")

set_property(DIRECTORY PROPERTY ADDITIONAL_CLEAN_FILES "${CMAKE_CURRENT_BINARY_DIR}/*_out.*")
