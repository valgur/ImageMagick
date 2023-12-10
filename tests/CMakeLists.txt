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

enable_testing()

# Validate Test
add_executable(validate validate.c)
target_link_libraries(validate PRIVATE MagickCore MagickWand)
add_test(NAME validate_test COMMAND validate)

# Drawtest
add_executable(drawtest drawtest.c)
target_link_libraries(drawtest PRIVATE MagickCore MagickWand)
add_test(NAME drawtest_test COMMAND drawtest)

# Wandtest
add_executable(wandtest wandtest.c)
target_link_libraries(wandtest PRIVATE MagickCore MagickWand)
add_test(NAME wandtest_test COMMAND wandtest)

set_directory_properties(PROPERTIES ADDITIONAL_CLEAN_FILES "tests/*_out.*")
