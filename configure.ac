AC_PREREQ([2.69])

AC_INIT([libzeep], 5.0, [maarten@hekkelman.com])

dnl Switch to a C++ compiler, and check if it works.
AC_LANG(C++)
AX_CXX_COMPILE_STDCXX_17([noext])

AC_CONFIG_SRCDIR([lib-http/src/connection.cpp])
AC_CONFIG_AUX_DIR(config)
AC_CONFIG_MACRO_DIR([config/m4])

AC_PREFIX_DEFAULT(/usr/local)

AC_PROG_INSTALL

dnl Shared libraries are not convenient
LT_INIT([disable-shared])
AC_SUBST(LIBTOOL_DEPS)

dnl versioning
LZ_CURRENT=5
LZ_REVISION=0
LZ_AGE=0

LZ_TL_CURRENT="${LZ_CURRENT}"
LZ_LT_VERSION="${LZ_CURRENT}:${LZ_REVISION}:${LZ_AGE}"

AC_SUBST(LZ_TL_CURRENT)
AC_SUBST(LZ_LT_VERSION)

AC_PATH_PROG([SHELL], [sh])

AC_ARG_VAR([DEBUG], [Build a debug version of the library])

AC_ARG_VAR([MRC], [Specify a location for the mrc executable])

dnl We really want to use mrc
if test "x$MRC" = "x"; then
	AC_PATH_PROG([MRC], [mrc])
fi

if test "x$MRC" = "x"; then
	AC_MSG_WARN([mrc not found, building without support for resources.])
else
	mrc_version=`${MRC} --version 2>&1 | grep "^.*mrc version" | \\
               sed -e 's/^.*mrc version *//'`
	if test "x${mrc_version}" = "x" || test "x${mrc_version}" = "x0.1"; then
         AC_MSG_WARN([Only mrc version 1.2 or greater can be used with libzeep.])
         AC_MSG_ERROR([Please upgrade your mrc resource compiler.])
	fi
fi

AX_PTHREAD(
	[
		LIBS="$PTHREAD_LIBS $LIBS"
		CXXFLAGS="$CXXFLAGS $PTHREAD_CFLAGS"
	]
)

AC_CHECK_HEADER([filesystem], [], [AC_MSG_ERROR([The file <filesystem> is missing, perhaps you should install a more recent libstdc++ implementation.])])

dnl check if we need stdc++fs as library
AC_TRY_LINK(
	[#include <filesystem>],
	[(void)std::filesystem::current_path();],
	[],
	[
		LIBS="$LIBS -lstdc++fs"

		AC_TRY_LINK(
			[#include <filesystem>],
			[(void)std::filesystem::current_path();],
			[],
			[
				AC_MSG_ERROR([Could not link filesystem])
			]
		)
	]
)

AX_BOOST_BASE([1.65.1], [], [
	AC_MSG_ERROR([Sorry, your boost is not found or not up-to-date.])
])
AX_BOOST_ASIO
AX_BOOST_PROGRAM_OPTIONS
AX_BOOST_DATE_TIME

dnl for the documentation
AC_ARG_ENABLE(
	documentation,
	[AS_HELP_STRING([--enable-documentation], [Generate documentation])])
AC_ARG_VAR([DOXYGEN],
	[Path to doxygen needed to build reference documentation])
AC_PATH_TOOL([DOXYGEN], [doxygen], [nodoxygen])
AC_PATH_TOOL([QUICKBOOK], [quickbook], [noquickbook])
AC_PATH_TOOL([XSLTPROC], [xsltproc], [noxsltproc])
AC_PATH_TOOL([FOP], [fop], [nofop])
AC_PATH_TOOL([BJAM], [bjam], [nobjam])

AS_IF([test "$enable_documentation" = "yes" && test "$DOXYGEN" = "nodoxygen" -o "$QUICKBOOX" = "noquickbook" -o "$XSLTPROC" = "noxsltproc" -o "$FOP" = "nofop" -o "$BJAM" = "nobjam"],
	[AC_MSG_ERROR([could not find the tools necessary to build the documentation])])

AM_CONDITIONAL([BUILD_DOCS], [[test "$enable_documentation" = "yes"]])

BUILD_DIR="$abs_top_builddir"

dnl Process Makefile.in to create Makefile
AC_OUTPUT([GNUmakefile
		   lib-xml/GNUmakefile
		   lib-json/GNUmakefile
		   lib-http/GNUmakefile
		   lib-xml/libzeep-xml.pc
		   lib-json/libzeep-json.pc
		   lib-http/libzeep-http.pc])
