import ballerina/log;

# Logs a debug message with the given message and module name.
#
# + ctx - The HTTP request context.
# + message - The message to be logged.
# + keyValues - Key value pairs to be logged.
public isolated function logDebug(Context ctx, string message, log:KeyValues keyValues = {}) {
    string[] keys = ctx.keys();
    foreach string key in keys {
        keyValues[key] = <anydata>ctx.get(key);
    }
    log:printDebug(message, keyValues = keyValues);
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
    string[] keys = ctx.keys();
    foreach string key in keys {
        keyValues[key] = <anydata>ctx.get(key);
    }
    log:printInfo(message, keyValues = keyValues);
}

# Function to log the error messages
#
# + ctx - http request context
# + message - message to be logged
# + err - error object
# + keyValues - Key value pairs to be logged.
public isolated function logError(Context ctx, string message, error err, log:KeyValues keyValues = {}) {
    string[] keys = ctx.keys();
    foreach string key in keys {
        keyValues[key] = <anydata>ctx.get(key);
    }
    log:printError(message, err, keyValues = keyValues);

}

# Function to log the warning messages
#
# + ctx - http request context  
# + message - message to be logged  
# + err - error object if any
# + keyValues - Key value pairs to be logged.
public isolated function logWarn(Context ctx, string message, error? err, log:KeyValues keyValues = {}) {
    string[] keys = ctx.keys();
    foreach string key in keys {
        keyValues[key] = <anydata>ctx.get(key);
    }
    log:printWarn(message, err, keyValues = keyValues);
}
