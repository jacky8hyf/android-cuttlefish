"""Generates src/config.h from src/config.h.in."""

CONFIG_H_SUBSTITUTIONS_COMMON = {
    "#undef PACKAGE": "#define PACKAGE \"breakpad\"",
    "#undef PACKAGE_BUGREPORT": "#define PACKAGE_BUGREPORT \"google-breakpad-dev@googlegroups.com\"",
    "#undef PACKAGE_NAME": "#define PACKAGE_NAME \"breakpad\"",
    "#undef PACKAGE_STRING": "#define PACKAGE_STRING \"breakpad 0.1\"",
    "#undef PACKAGE_TARNAME": "#define PACKAGE_TARNAME \"breakpad\"",
    "#undef PACKAGE_URL": "#define PACKAGE_URL \"\"",
    "#undef PACKAGE_VERSION": "#define PACKAGE_VERSION \"0.1\"",
    "#undef VERSION": "#define VERSION \"0.1\"",
}

CONFIG_H_SUBSTITUTIONS_LINUX = CONFIG_H_SUBSTITUTIONS_COMMON | {
    "#undef HAVE_ARC4RANDOM": "#define HAVE_ARC4RANDOM 1",
    "#undef HAVE_A_OUT_H": "#define HAVE_A_OUT_H 1",
    "#undef HAVE_CXX17": "#define HAVE_CXX17 1",
    "#undef HAVE_GETCONTEXT": "#define HAVE_GETCONTEXT 1",
    "#undef HAVE_GETRANDOM": "#define HAVE_GETRANDOM 1",
    "#undef HAVE_INTTYPES_H": "#define HAVE_INTTYPES_H 1",
    "#undef HAVE_MEMFD_CREATE": "#define HAVE_MEMFD_CREATE 1",
    "#undef HAVE_PTHREAD": "#define HAVE_PTHREAD 1",
    "#undef HAVE_STDINT_H": "#define HAVE_STDINT_H 1",
    "#undef HAVE_STDIO_H": "#define HAVE_STDIO_H 1",
    "#undef HAVE_STDLIB_H": "#define HAVE_STDLIB_H 1",
    "#undef HAVE_STRINGS_H": "#define HAVE_STRINGS_H 1",
    "#undef HAVE_STRING_H": "#define HAVE_STRING_H 1",
    "#undef HAVE_SYS_MMAN_H": "#define HAVE_SYS_MMAN_H 1",
    "#undef HAVE_SYS_RANDOM_H": "#define HAVE_SYS_RANDOM_H 1",
    "#undef HAVE_SYS_STAT_H": "#define HAVE_SYS_STAT_H 1",
    "#undef HAVE_SYS_TYPES_H": "#define HAVE_SYS_TYPES_H 1",
    "#undef HAVE_UNISTD_H": "#define HAVE_UNISTD_H 1",
    "#undef STDC_HEADERS": "#define STDC_HEADERS 1",
}

def _breakpad_generate_config_header_impl(ctx):
    substitutions = CONFIG_H_SUBSTITUTIONS_LINUX

    ctx.actions.expand_template(
        template = ctx.file.src,
        output = ctx.outputs.out,
        substitutions = substitutions,
    )

breakpad_generate_config_header = rule(
    attrs = {
        "src": attr.label(
            mandatory = True,
            allow_single_file = True,
        ),
        "out": attr.output(mandatory = True),
    },
    implementation = _breakpad_generate_config_header_impl,
)
