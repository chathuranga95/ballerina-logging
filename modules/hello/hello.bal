public function sayHello(string name) returns string|error {
    if name == "voldemort" {
        return error("can't say hello to unspeakable");
    }
    return "Hello, " + name;
}
