#!/bin/sh
set -euxo pipefail
/shell2http -form -export-all-vars -show-errors -include-stderr -port $SHELL2HTTP_PORT /dredd "dredd \$v_SWAGGER_LOCATION \$v_SERVER_URL" /swaggerCli "swagger-cli validate \$v_SWAGGER_LOCATION"
