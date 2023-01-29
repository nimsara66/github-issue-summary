import ballerinax/github;
import ballerina/log;
import ballerina/http;

configurable string githubAccessToken = ?;

type SummarizedIssue record {
    int number;
    string title;
};

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + return - string name with hello message or error
    resource function get summary/[string orgName]/repository/[string repoName]() returns SummarizedIssue[]|error {
        log:printInfo("new request for  " + orgName + " " + repoName);

        github:Client githubEp = check new (config = {
            auth: {
                token: githubAccessToken
            }
        });

        stream<github:Issue, error?> getIssuesResponse = check githubEp->getIssues(owner = orgName, repositoryName = repoName, issueFilters = {
            states: [github:ISSUE_OPEN]
        });

        SummarizedIssue[] summary = check from github:Issue issue 
        in getIssuesResponse 
        order by issue.number descending 
        limit 10
        select { 
            number:issue.number,
            title:issue.title.toString()
            };

        // Send a response back to the caller.
        return summary;
    }
}
