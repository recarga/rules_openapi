load("//openapi:flat.bzl", "openapi_flat_artifact")

java_binary(
    name = "run",
    main_class = "io.bazel.rules.openapi.OpenApiFlattener",
    visibility = ["//visibility:public"],
    runtime_deps = [
        "//openapi/private/src/main:lib",
        openapi_flat_artifact("org.slf4j:slf4j-api"),
        openapi_flat_artifact("org.slf4j:slf4j-nop"),
    ],
)
