module {
    public type VoteOption = { #Approve; #Reject };

    public type VoteResult = { #Approved; #Rejected; #Tied };

    private var votes : Trie.Trie<Text, [VoteOption]> = Trie.empty();

    public func vote(projectId: Text, vote: VoteOption) : VoteResult {
        let currentVotes = votes.get(projectId) ?: [];
        votes.put(projectId, currentVotes # [vote]);

        let (approveCount, rejectCount) = foldArray(votes.get(projectId)?, (0, 0), 
            func ((approve, reject), v) {
                switch (v) {
                    case (#Approve) { (approve + 1, reject) };
                    case (#Reject) { (approve, reject + 1) };
                }
            }
        );

        if (approveCount > rejectCount) {
            return #Approved;
        } else if (rejectCount > approveCount) {
            return #Rejected;
        } else {
            return #Tied;
        }
    }

    private func foldArray<T, S>(arr: [T], init: S, f: (S, T) -> S) : S {
        var acc = init;
        for (item in arr.vals()) {
            acc := f(acc, item);
        };
        return acc;
    }
}
