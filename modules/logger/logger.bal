import ballerina/log;

isolated function getKeyValuesWithContext(Context ctx, log:KeyValues keyValues) returns log:KeyValues {
    string[] keys = ctx.keys();
    log:KeyValues keyValuesWithContext = keyValues.clone();
    foreach string key in keys {
        keyValuesWithContext[key] = <anydata>ctx.get(key);
    }
    return keyValuesWithContext;
}

# Logs a debug message with the given message and module name.
#
# + ctx - The HTTP request context.
# + message - The message to be logged.
# + keyValues - Key value pairs to be logged.
public isolated function logDebug(Context ctx, string message, log:KeyValues keyValues = {}) {
    log:printDebug(message, keyValues = getKeyValuesWithContext(ctx, keyValues));
}

# Logs an informational message with the given message and module name.
#
# This function takes in the HTTP request context, message to be logged and the name of the module as parameters.
# It then logs the message as an informational message.
#
# + ctx - The HTTP request context.
# + message - The message to be logged.
# + keyValues - Key value pairs to be logged.
public isolated function logInfo(Context ctx, string message, log:KeyValues keyValues = {}) {
    log:printInfo(message, keyValues = getKeyValuesWithContext(ctx, keyValues));
}

# Function to log the error messages
#
# + ctx - http request context
# + message - message to be logged
# + err - error object
# + keyValues - Key value pairs to be logged.
public isolated function logError(Context ctx, string message, error err, log:KeyValues keyValues = {}) {
    log:printError(message, keyValues = getKeyValuesWithContext(ctx, keyValues));
}

# Function to log the warning messages
#
# + ctx - http request context  
# + message - message to be logged  
# + err - error object if any
# + keyValues - Key value pairs to be logged.
public isolated function logWarn(Context ctx, string message, error? err, log:KeyValues keyValues = {}) {
    log:printWarn(message, keyValues = getKeyValuesWithContext(ctx, keyValues));
}
