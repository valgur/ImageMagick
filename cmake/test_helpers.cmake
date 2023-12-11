function(add_tap_test TEST_FILE)
  set(TEST_ENV
      "MAGICK=${CMAKE_BINARY_DIR}/utilities/magick"
      "ANIMATE=${CMAKE_BINARY_DIR}/utilities/animate"
      "COMPARE=${CMAKE_BINARY_DIR}/utilities/compare"
      "COMPOSITE=${CMAKE_BINARY_DIR}/utilities/composite"
      "CONJURE=${CMAKE_BINARY_DIR}/utilities/conjure"
      "CONVERT=${CMAKE_BINARY_DIR}/utilities/convert"
      "DISPLAY=${CMAKE_BINARY_DIR}/utilities/display"
      "IDENTIFY=${CMAKE_BINARY_DIR}/utilities/identify"
      "IMPORT=${CMAKE_BINARY_DIR}/utilities/import"
      "MOGRIFY=${CMAKE_BINARY_DIR}/utilities/mogrify"
      "MONTAGE=${CMAKE_BINARY_DIR}/utilities/montage"
      "STREAM=${CMAKE_BINARY_DIR}/utilities/stream"

      "VALIDATE=${CMAKE_BINARY_DIR}/tests/validate"
      "DRAWTEST=${CMAKE_BINARY_DIR}/tests/drawtest"
      "WANDTEST=${CMAKE_BINARY_DIR}/tests/wandtest"

      "SRCDIR=${CMAKE_CURRENT_BINARY_DIR}/"
      "srcdir=${CMAKE_CURRENT_BINARY_DIR}/"
      "TOPSRCDIR=${CMAKE_BINARY_DIR}/"
      "top_srcdir=${CMAKE_BINARY_DIR}/"
      "MAGICK_CONFIGURE_PATH=${CMAKE_BINARY_DIR}/config/"
      "MAGICK_FONT=${CMAKE_SOURCE_DIR}/PerlMagick/demo/Generic.ttf"
  )

  if(ARGC GREATER 1)
    set(TEST_NAME ${ARGV1})
  else()
    set(TEST_NAME ${TEST_FILE})
  endif()
  add_test(
      NAME ${TEST_NAME}
      COMMAND sh -c "sh ${CMAKE_CURRENT_BINARY_DIR}/${TEST_FILE}.tap | tee /dev/fd/2 | grep -q 'not ok' && exit 1 || exit 0"
      WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
  )
  set_tests_properties(${TEST_NAME} PROPERTIES ENVIRONMENT "${TEST_ENV}")
endfunction()

function(copy_test_resources suffix)
  add_custom_target(copy_test_resources_${suffix} ALL)
  file(GLOB TEST_RESOURCES "${CMAKE_CURRENT_SOURCE_DIR}/*.tap" "${CMAKE_CURRENT_SOURCE_DIR}/*.miff" "${CMAKE_CURRENT_SOURCE_DIR}/*.pnm")
  foreach(TEST_RESOURCE ${TEST_RESOURCES})
    get_filename_component(NAME ${TEST_RESOURCE} NAME)
    set(SRC ${TEST_RESOURCE})
    set(DST ${CMAKE_CURRENT_BINARY_DIR}/${NAME})
    add_custom_command(
        OUTPUT ${DST}
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${SRC} ${DST}
        DEPENDS ${SRC}
    )
    add_custom_target(copy_${NAME} ALL DEPENDS ${SRC} ${DST})
    add_dependencies(copy_test_resources_${suffix} copy_${NAME})
  endforeach()

  file(WRITE ${CMAKE_BINARY_DIR}/common.shi "")
  file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/common.shi "")
  file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/tests/common.shi "")
endfunction()

set_property(DIRECTORY PROPERTY ADDITIONAL_CLEAN_FILES "${CMAKE_BINARY_DIR}/*_out.*")
