openapi: 3.0.2
info:
  title: Recargapay APIs
  version: 0.0.1-SNAPSHOT
  description: A collection of all APIs served under this repository
  termsOfService: 'http://swagger.io/terms/'
  contact:
    email: pablo.belloc@recargapay.com
  license:
    name: Apache 2.0
    url: 'http://www.apache.org/licenses/LICENSE-2.0.html'
servers:
  - url: 'http://localhost:8080/v2'
    description: Local recarga-users
  - url: 'https://api-dev.recarga.com/api/v2'
    description: Devbox
  - url: 'https://api-staging.recarga.com/api/v2'
    description: Staging
  - url: 'https://api.recarga.com/api/v2'
    description: Production
  - url: 'https://ops-staging.recargapay.com/users-api-proxy/'
    description: Ops Proxy (Staging)
  - url: 'https://ops.recargapay.com/users-api-proxy/'
    description: Ops Proxy
paths:
security:
  - Bearer: []
  - Internal: []
  - PreAuthAdminUser: []
    PreAuthAdminUserRoles: []
  - AdminProxyStaging: []
  - AdminProxy: []
components:
