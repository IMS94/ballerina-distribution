import ballerina/http;

listener http:Listener securedEP = new(9090, config = {
    secureSocket: {
        keyStore: {
            path: "../resources/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

// The service can be secured with OAuth2 authentication and can be authorized
// optionally. OAuth2 authentication can be enabled by setting the
// `http:OAuth2IntrospectionConfig` configurations.
// Authorization is based on scopes. A scope maps to one or more groups.
// Authorization can be enabled by setting the `string|string[]` type
// configurations.
@http:ServiceConfig {
    auth: [
        {
            oauth2IntrospectionConfig: {
                url: "https://localhost:9999/oauth2/token/introspect",
                tokenTypeHint: "access_token",
                scopeKey: "scp",
                clientConfig: {
                    secureSocket: {
                        trustStore: {
                            path: "../resources/ballerinaTruststore.p12",
                            password: "ballerina"
                        }
                    }
                }
            },
            scopes: ["hello"]
        }
    ]
}
service /foo on securedEP {

    // It is optional to override the authentication and authorization
    // configurations at the resource levels. Otherwise, the service auth
    // configurations will be applied automatically to the resources as well.
    resource function get bar() returns string {
        return "Hello, World!";
    }
}
