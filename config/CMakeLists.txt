#  Copyright 1999 ImageMagick Studio LLC, a non-profit organization
#  dedicated to making software imaging solutions freely available.
#
#  You may not use this file except in compliance with the License.  You may
#  obtain a copy of the License at
#
#    https://imagemagick.org/script/license.php
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

# Where architecture-independent configuration files get installed
set(SHARE_PATH share/ImageMagick-${MAGICK_VERSION_MAJOR})
# Where architecture-dependent configuration files get installed
set(SHAREARCH_PATH lib/ImageMagick-${MAGICK_VERSION_MAJOR})
# Where architecture-dependent configuration files get installed
set(CONFIGURE_PATH ${SHARE_PATH}/config)

install(
  FILES
    english.xml
    francais.xml
    locale.xml
  DESTINATION ${SHARE_PATH}/config
)

install(
  FILES
    configure.xml
  DESTINATION ${SHAREARCH_PATH}/config
)

install(
  FILES
    colors.xml
    delegates.xml
    log.xml
    mime.xml
    policy.xml
    quantization-table.xml
    thresholds.xml
    type.xml
    type-apple.xml
    type-dejavu.xml
    type-ghostscript.xml
    type-urw-base35.xml
    type-windows.xml
  DESTINATION ${CONFIGURE_PATH}/config
)
