module {
    import Project "mo:backend/Project";

    public func auditProject(projectId: Text) : Text {
        switch (Project.getProject(projectId)) {
            case (?project) {
                if (project.spent > project.budget) {
                    return "Audit Failed: Budget overspent!";
                } else {
                    return "Audit Successful: Project within budget.";
                };
            };
            case _ {
                return "Audit Failed: Project not found.";
            };
        };
    }
}
