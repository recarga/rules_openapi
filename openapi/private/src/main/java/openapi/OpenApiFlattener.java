package io.bazel.rules.openapi;

import com.fasterxml.jackson.databind.ObjectWriter;
import io.swagger.v3.core.util.Yaml;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.PathItem;
import io.swagger.v3.oas.models.media.Schema;
import io.swagger.v3.parser.OpenAPIV3Parser;
import io.swagger.v3.parser.core.models.ParseOptions;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

public final class OpenApiFlattener {

  private OpenApiFlattener() {}

  public static void main(final String[] args) throws IOException {
    String template = args[0];
    File out = new File(args[1]);
    File base_out = new File(args[2]);
    if (!base_out.exists()) {
      if (!base_out.mkdirs()) {
        throw new IOException(String.format("Could not create %s", base_out));
      }
    }
    List<String> apis = new ArrayList<>(Arrays.asList(args).subList(3, args.length));

    ObjectWriter om = Yaml.mapper().writerWithDefaultPrettyPrinter();

    ParseOptions parseOptions = new ParseOptions();
    parseOptions.setResolve(true);

    OpenAPI merged = new OpenAPIV3Parser().read(template, null, parseOptions);

    for (String api : apis) {
      OpenAPI openApi = new OpenAPIV3Parser().read(api, null, parseOptions);

      for (Map.Entry<String, PathItem> pathItemEntry : openApi.getPaths().entrySet()) {
        merged.path(pathItemEntry.getKey(), pathItemEntry.getValue());
      }

      for (Map.Entry<String, Schema> schemaEntry :
          openApi.getComponents().getSchemas().entrySet()) {
        merged.schema(schemaEntry.getKey(), schemaEntry.getValue());
      }

      om.writeValue(new File(base_out, new File(api).getName()), openApi);
    }

    om.writeValue(out, merged);
  }
}
