load("//openapi:flat.bzl", "openapi_flat_artifact")

filegroup(
    name = "srcs",
    srcs = glob(["java/**/*.java"]),
)

java_library(
    name = "lib",
    srcs = [":srcs"],
    visibility = [
        "//openapi/private:__subpackages__",
    ],
    deps = [
        openapi_flat_artifact("com.fasterxml:jackson-core-jackson-databind"),
        openapi_flat_artifact("io.swagger.core.v3:swagger-core"),
        openapi_flat_artifact("io.swagger.core.v3:swagger-models"),
        openapi_flat_artifact("io.swagger.parser.v3:swagger-parser-core"),
        openapi_flat_artifact("io.swagger.parser.v3:swagger-parser-v3"),
    ],
)
