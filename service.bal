import ballerina/log;
import ballerina/http;

type SummarizedIssue record {
    int number;
    string title;
};

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + return - string name with hello message or error
    resource function get summary/[string orgName]/repository/[string repoName]() returns SummarizedIssue|error {
        log:printInfo("new request for  "+orgName+" "+repoName);

    SummarizedIssue sample = {
        number: 1234,
        title: "No need to inprove Home UI"
    };

        // Send a response back to the caller.
        return sample;
    }
}
