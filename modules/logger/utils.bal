import ballerina/http;
import ballerina/lang.array;

# function to check and get values from http:RequestContext.
#
# if the value does not exist, it will return an empty string
#
# + ctx - http:RequestContext
# + key - string key
# + return - string value
public isolated function getFromContext(http:RequestContext ctx, string key) returns string {
    if ctx.hasKey(key) {
        return ctx.get(key).toString();
    }
    return "";
}

# Returns a context with orgId and module
#
# + orgId - organization id
# + module - module name
# + return - Context context with orgId and module
public isolated function getContext(string orgId, string module) returns Context {
    Context context = {
        orgId: orgId,
        module: module
    };
    return context;
}

# Returns a context with http requestId, orgId and module. Use this context when the request is coming from a http client
#
# + ctx -  http request context
# + orgId - organization id
# + module - module name
# + return - Context context with http requestId, orgId and module
public isolated function getHttpRequestContext(http:RequestContext ctx, string orgId, string module) returns Context {
    Context context = {
        requestId: getFromContext(ctx, REQUEST_ID),
        orgId: orgId,
        module: module
    };
    return context;
}

public isolated function base64Decode(string estr) returns string|error {
    byte[] fromBase64Bytes = check array:fromBase64(estr);
    string decodedServiceId = check string:fromBytes(fromBase64Bytes);
    return decodedServiceId;
}
