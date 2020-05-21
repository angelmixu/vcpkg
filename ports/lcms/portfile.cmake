include(vcpkg_common_functions)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(ADDITIONAL_PATCH "shared.patch")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mm2/Little-CMS
    REF ea174b2f38b0cb782c61a603ca4117d4b2147cd7
    SHA512 000f85c52b9d823c39d58fef1aec1df8a1e81a2d6e8752f24daf08c0638e13b1e4435220be0e5aab26620c8ba0eefa2bea0596da6681daae05bea81ec89fccc2
    HEAD_REF master
    PATCHES
        remove_library_directive.patch
        ${ADDITIONAL_PATCH}
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets()
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/lcms RENAME copyright)
