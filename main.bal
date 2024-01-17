import ballerina_logging.logger;
import ballerina_logging.persistent;
import ballerina_logging.hello;

public function main() {
    logger:Context context = logger:getContext("org-001234", "main");
    context["mood"] = {"happy": "much"};

    // Test log lines to demonstrate log levels and formatted logs
    logger:logDebug(context, "This is a debug log with context and key value pairs", {"key1":"value1", "key2":"value2"});
    logger:logInfo(context, "This is an info log with context and key value pairs", {"key1":"value1", "key2":"value2"});
    logger:logWarn(context, "This is a warn log with context and key value pairs", error("A mild error happened"), {"key1":"value1", "key2":"value2"});
    logger:logError(context, "This is an error log with context and key value pairs", error("A severe error happened"), {"key1":"value1", "key2":"value2"});

    // Returning error with message at each execution point. Results in structured error logs. Result: resources/log-scenario-1.json
    persistent:PersistentError? saveResult = persistent:saveOnDisk("error", "error message");
    if saveResult is () {
        logger:logInfo(context, "Data saved successfully");
    }
    if saveResult is persistent:PersistentError {
        logger:logError(context, "Error occurred while saving data", saveResult);
    }

    // Simply check return. Results in flattened stack trace. Result: resources/log-scenario-2.json
    persistent:DataItem|persistent:PersistentError readResult = persistent:getFromDisk("test-key");
    if readResult is persistent:DataItem {
        logger:logInfo(context, "Data saved successfully");
    }
    if readResult is persistent:PersistentError {
        logger:logError(context, "Error occurred while reading data", readResult);
    }

    // do-on-fail block. Similar to the type-guarding scenario. Result: resources/log-scenario-3.json
    // Note: The following block will result in a failure in sayHello function.
    //       We can change the value of variable: `name` and see the persistent error.
    do {
        string name = "voldemort";
        string helloResp = check hello:sayHello(name);
        logger:logInfo(context, "Hello response received successfully", {"helloResp": helloResp});
        check persistent:saveOnDisk("error", helloResp);
        logger:logInfo(context, "Hello response saved successfully");
    } on fail error persistentError {
        if (persistentError is persistent:PersistentError) {
            logger:logError(context, "Error occurred while saving hello response", persistentError, {"customKey": "customValue"});
        } else {
            logger:logError(context, "Error occurred while greeting", persistentError, {"customKey": "customValue"});
        }
    }
}
