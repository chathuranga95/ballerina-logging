public function saveOnDisk(string key, string value) returns PersistentError? {
    if (key == "error") {
        DataItem|PersistentError dbSaveResult = saveToDatabase({"key": key, "value": value});
        if (dbSaveResult is PersistentError) {
            return error PersistentError("Persistent error occurred. Key is not supported.", dbSaveResult, key = key);
        }
    }
    return;
}

public function getFromDisk(string key) returns DataItem|PersistentError {
    return check getFromDatabase(key);
}
