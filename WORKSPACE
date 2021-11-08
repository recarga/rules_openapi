workspace(name = "io_bazel_rules_openapi")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

RULES_JVM_EXTERNAL_VERSION = "4.1"
RULES_JVM_EXTERNAL_SHA256 = "f36441aa876c4f6427bfb2d1f2d723b48e9d930b62662bf723ddfb8fc80f0140"

http_archive(
    name = "rules_jvm_external",
    sha256 = RULES_JVM_EXTERNAL_SHA256,
    strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_VERSION,
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_VERSION,
)

load("@rules_jvm_external//:repositories.bzl", "rules_jvm_external_deps")

rules_jvm_external_deps()

load("@rules_jvm_external//:setup.bzl", "rules_jvm_external_setup")

rules_jvm_external_setup()

load("//openapi:openapi.bzl", "openapi_repositories")

openapi_repositories()

openapi_repositories(
    codegen_cli_version = "4.3.1",
    codegen_cli_sha256 = "f438cd16bc1db28d3363e314cefb59384f252361db9cb1a04a322e7eb5b331c1",
    prefix = "io_bazel_rules_openapi_openapi_4",
    codegen_cli_provider = "openapi"
)

openapi_repositories(
    codegen_cli_version = "5.0.0",
    codegen_cli_sha256 = "839fade01e54ce1eecf012b8c33adb1413cff0cf2e76e23bc8d7673f09626f8e",
    prefix = "io_bazel_rules_openapi_openapi_5",
    codegen_cli_provider = "openapi"
)

load("//openapi:flat.bzl", "openapi_flat_repositories")

openapi_flat_repositories()
