function gcm
    # Step 1: Get current branch name
    set branch_name (git symbolic-ref --short HEAD)

    # Step 2: Extract Jira ticket (e.g., CHK-1354)
    set jira_ticket (string match -r -i --groups-only '([a-z]+-\d+)' $branch_name | string upper)

    if test -z "$jira_ticket"
        echo "❌ No Jira ticket found in branch name: $branch_name"
        return 1
    end

    # Step 3: Prompt for commit message
    read -P "Enter commit message (default: WIP): " commit_message

    if test -z "$commit_message"
        set commit_message WIP
    end

    # Step 4: Run git commit
    set formatted_msg "[$jira_ticket] $commit_message"
    git commit -m "$formatted_msg"
end
