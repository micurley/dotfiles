function gcm
    # Step 1: Get current branch name
    set branch_name (git symbolic-ref --short HEAD 2>/dev/null)

    # Step 2: Extract Jira ticket (e.g., CHK-1354)
    set jira_ticket (string match -r -i --groups-only '([a-z]+-\d+)' $branch_name | string upper)

    if test -z "$jira_ticket"
        echo "❌ No Jira ticket found in branch name: $branch_name"
        return 1
    end

    # Step 3: Use passed argument if provided, else prompt
    if test (count $argv) -gt 0
        set commit_message "$argv"
    else
        read -P "Enter commit message (default: WIP): " commit_message
        if test -z "$commit_message"
            set commit_message WIP
        end
    end

    # Step 4: Commit
    set formatted_msg "[$jira_ticket] $commit_message"
    git commit -m "$formatted_msg"
end
