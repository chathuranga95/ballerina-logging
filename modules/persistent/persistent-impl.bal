function getFromDatabase(string key) returns DataItem|PersistentError {
    return error("SQL error while connecting to the database", code = 101);
}

function saveToDatabase(DataItem item) returns DataItem|PersistentError {
    return error("SQL error occurred.", code = 100);
}