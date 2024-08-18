import Project "mo:backend/Project";
import Voting "mo:backend/Voting";
import Audit "mo:backend/Audit";

actor CivicChain {
    stable var projects = Project.ProjectMap();

    // Register a new project
    public shared(msg) func registerProject(name: Text, budget: Nat, deadline: Int) : async Text {
        let projectId = Project.createProject(projects, name, budget, deadline);
        return "Project registered with ID: " # projectId;
    }

    // Vote on a project
    public shared(msg) func voteOnProject(projectId: Text, vote: Voting.VoteOption) : async Text {
        let result = Voting.vote(projectId, vote);
        return "Voted on project: " # result;
    }

    // Audit a project
    public shared(msg) func auditProject(projectId: Text) : async Text {
        let result = Audit.auditProject(projectId);
        return result;
    }

    // Get project details
    public query func getProjectDetails(projectId: Text) : async ?Project.ProjectDetails {
        return Project.getProject(projects, projectId);
    }
}
