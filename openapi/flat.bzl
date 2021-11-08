"""Bazel rules for generating sources and libraries from openapi schemas

"""

load("@rules_jvm_external//:defs.bzl", "artifact", "maven_install")

REPOSITORY_NAME = "openapi_flat"

def openapi_flat_repositories():
    maven_install(
        name = REPOSITORY_NAME,
        artifacts = [
            "io.swagger.parser.v3:swagger-parser-v3:2.0.28",
            "org.slf4j:slf4j-nop:1.7.32",
        ],
        repositories = [
            "https://repo.maven.apache.org/maven2/",
        ],
    )

def openapi_flat_artifact(artifact_id):
    return artifact(
        artifact_id,
        repository_name = REPOSITORY_NAME,
    )

def _impl(ctx):
    out = ctx.actions.declare_file("%s.yaml" % ctx.label.name)

    inputs = [ctx.file.template] + [f for f in ctx.files.srcs] + [f for f in ctx.files.deps]
    outputs = [out] + [ctx.actions.declare_file("%s/%s" % (ctx.label.name, f.basename)) for f in ctx.files.srcs]
    args = [ctx.file.template.path, out.path, "%s/%s" % (out.dirname, ctx.label.name)] + [f.path for f in ctx.files.srcs]

    ctx.actions.run(
        inputs = inputs,
        outputs = outputs,
        arguments = args,
        progress_message = "generating openapi spec %s" % out.basename,
        executable = ctx.executable._executable,
    )

    return [
        DefaultInfo(files = depset(outputs)),
    ]

# TODO agregar opciones generar el merge? generar solo los individuales?
openapi_flat = rule(
    attrs = {
        # downstream dependencies
        "deps": attr.label_list(),
        "srcs": attr.label_list(mandatory = True, allow_files = True),
        "template": attr.label(
            doc = "Template file to use for the openapi.yaml",
            default = "//openapi/private/templates:openapi.tpl",
            allow_single_file = True,
        ),
        "_executable": attr.label(
            default = Label("//openapi/private:run"),
            executable = True,
            cfg = "exec",
        ),
    },
    implementation = _impl,
)
