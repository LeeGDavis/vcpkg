
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO stephen-webb/logging-log4cxx
    REF 71092038f9d79d78c4c230e63e219d512e314f13
    SHA512 344c3d10f2afe4e147d67fcee01c2a04fcd5f321b6260cfeebc72b0d8d2234cb81e0ccfe72906dcf718cea8a120c35010d2e503fa8aec53d3d7e95d091c8c432
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DLOG4CXX_INSTALL_PDB=OFF # Installing pdbs failed on debug static. So, disable it and let vcpkg_copy_pdbs() do it
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/debug/bin)
endif()

vcpkg_copy_pdbs()

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
