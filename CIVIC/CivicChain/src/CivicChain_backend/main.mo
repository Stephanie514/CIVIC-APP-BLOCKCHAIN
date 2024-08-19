import Array "mo:base/Array";

actor CivicChain {

    // State variables
    var projects: [(Nat, Text)] = [(1, "Project A"), (2, "Project B")];
    var votes: [(Nat, Nat)] = [];

    // Function to get projects
    public query func getProjects(): async [(Nat, Text)] {
        return projects;
    };

    // Function to vote for a project
    public func vote(projectId: Nat): async Text {
        let projectExists = Array.find<(Nat, Text)>(projects, func(project) { project.0 == projectId });
        if (projectExists != null) {
            // Increment the vote count if the project exists
            votes := Array.append(votes, [(projectId, 1)]);
            return "Vote recorded!";
        } else {
            return "Project not found!";
        };
    };

    // Function to get votes for a project
    public query func getVotes(projectId: Nat): async Nat {
        let totalVotes = Array.foldLeft<(Nat, Nat), Nat>(votes, 0, func(acc, vote) {
            if (vote.0 == projectId) {
                acc + vote.1
            } else {
                acc
            }
        });
        return totalVotes;
    };

    // A simple greeting function (as in your original code)
    public query func greet(name: Text): async Text {
        return "Hello, " # name # "!";
    };
}