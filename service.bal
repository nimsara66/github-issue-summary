import ballerina/log;
import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + return - string name with hello message or error
    resource function get summary/[string orgName]/repository/[string repoName]() returns string|error {
        log:printInfo("new request for  "+orgName+" "+repoName);

        // Send a response back to the caller.
        return "Hello, World";
    }
}
