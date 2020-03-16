
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO stephen-webb/logging-log4cxx
    REF master
    SHA512 5cc4d8b8b8d43c7753b2c57c8f3f97bfef98b1ded353dc9ac1185b4ff64e2d01869f68bcfb32123282e49015488526b045f716f59bb71de3e6b0c78c3cb1b216
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
