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

set(SHARE_PATH share/ImageMagick-${MAGICK_VERSION_MAJOR} CACHE INTERNAL "Installation path for platform-independent data")
set(SHAREARCH_PATH lib/ImageMagick-${MAGICK_VERSION}/config-${MagickQuantumDepth}${HDRI_SUFFIX} CACHE INTERNAL "Installation path for platform-dependent data")
set(CONFIGURE_PATH etc/ImageMagick-${MAGICK_VERSION_MAJOR} CACHE INTERNAL "Installation path for configuration files")

set(DATA_FILES
    english.xml
    francais.xml
    locale.xml
)

# TODO: needs to be generated
#set(PLATFORM_DATA_FILES
#    configure.xml
#)

set(CONFIG_FILES
    colors.xml
#    delegates.xml
    log.xml
    mime.xml
    quantization-table.xml
    thresholds.xml
#    type.xml
#    type-apple.xml
#    type-dejavu.xml
#    type-ghostscript.xml
#    type-urw-base35.xml
#    type-windows.xml
)

if(BUILD_TESTS)
  file(COPY ${DATA_FILES} ${PLATFORM_DATA_FILES} ${CONFIG_FILES}
      DESTINATION ${CMAKE_BINARY_DIR}/config
  )
  file(COPY policy-${SECURITY_POLICY}.xml
      DESTINATION ${CMAKE_BINARY_DIR}/config/policy.xml
  )
endif()

install(FILES ${DATA_FILES} DESTINATION ${SHARE_PATH})
#install(FILES ${PLATFORM_DATA_FILES} DESTINATION ${SHAREARCH_PATH})
install(FILES ${CONFIG_FILES} DESTINATION ${CONFIGURE_PATH})
install(FILES policy-${SECURITY_POLICY}.xml DESTINATION ${CONFIGURE_PATH}/policy.xml)
