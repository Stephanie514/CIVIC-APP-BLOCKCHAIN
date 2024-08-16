import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Array "mo:base/Array";

actor CivicChain {
  type Project = {
    id: Nat;
    name: Text;
    budget: Nat;
    startDate: Time.Time;
    endDate: Time.Time;
    milestones: [Text];
    completedMilestones: [Text];
    fundsDisbursed: Nat;
  };

  var projects: [Project] = [];

  public func addProject(name: Text, budget: Nat, milestones: [Text]) : async Nat {
    let projectId = projects.size();
    let newProject: Project = {
      id = projectId;
      name = name;
      budget = budget;
      startDate = Time.now();
      endDate = Time.now() + 7 * 24 * 60 * 60 * 1_000_000_000; // 7 days from start in nanoseconds
      milestones = milestones;
      completedMilestones = [];
      fundsDisbursed = 0;
    };
    projects := Array.append(projects, [newProject]);
    return projectId;
  };

  public query func getProjects() : async [Project] {
    return projects;
  };

  public func completeMilestone(projectId: Nat, milestone: Text) : async Bool {
    if (projectId < projects.size()) {
      let project = projects[projectId];
      if (Array.find(project.milestones, func(m: Text): Bool { m == milestone }) != null) {
        let updatedProject = { project with completedMilestones = Array.append(project.completedMilestones, [milestone]) };
        projects := Array.tabulate(projects.size(), func(i: Nat): Project {
          if (i == projectId) updatedProject else projects[i]
        });
        return true;
      } else {
        return false; // Milestone not found
      }
    } else {
      return false; // Invalid projectId
    }
  };

  public func disburseFunds(projectId: Nat, amount: Nat) : async Bool {
    if (projectId < projects.size()) {
      let project = projects[projectId];
      if (project.fundsDisbursed + amount <= project.budget) {
        let updatedProject = { project with fundsDisbursed = project.fundsDisbursed + amount };
        projects := Array.tabulate(projects.size(), func(i: Nat): Project {
          if (i == projectId) updatedProject else projects[i]
        });
        return true;
      } else {
        return false; // Exceeds budget
      }
    } else {
      return false; // Invalid projectId
    }
  };
}
