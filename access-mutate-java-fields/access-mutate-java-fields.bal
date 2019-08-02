import ballerinax/java;
import ballerina/io;

public function main() {
    float r = 4;
    // External field getter can be called like any other Ballerina function
    // If a filed is non-static, receiver instance has to be provided as the first parameter
    float l = 2 * pi() * r;
    io:println(l);
}

// Defines a Ballerina function which will act as getter to a Java field
public function pi() returns float = @java:FieldGet {
    name:"PI",
    class:"java/lang/Math"
} external;