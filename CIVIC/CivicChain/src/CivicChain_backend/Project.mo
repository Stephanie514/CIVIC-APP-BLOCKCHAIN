module {
    import Time "mo:base/Time";

    type ProjectDetails = {
        name: Text;
        budget: Nat;
        deadline: Int;
        spent: Nat;
        status: Status;
    };

    public type Status = { #Pending; #InProgress; #Completed };

    public type ProjectMap = Trie.Trie<Text, ProjectDetails>;

    public func createProject(map: ProjectMap, name: Text, budget: Nat, deadline: Int) : Text {
        let projectId = name # "_" # Time.now().toText();
        let projectDetails : ProjectDetails = {
            name = name;
            budget = budget;
            deadline = deadline;
            spent = 0;
            status = #Pending;
        };
        map.put(projectId, projectDetails);
        return projectId;
    }

    public func getProject(map: ProjectMap, projectId: Text) : ?ProjectDetails {
        return map.get(projectId);
    }

    public func updateStatus(map: ProjectMap, projectId: Text, newStatus: Status) : Bool {
        switch (map.get(projectId)) {
            case (?details) {
                map.put(projectId, { details with status = newStatus });
                return true;
            };
            case _ {
                return false;
            };
        };
    }
}
