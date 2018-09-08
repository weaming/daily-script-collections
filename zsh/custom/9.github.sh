function github-activity() {
    one=$1
    name=${one:=weaming}
    curl https://api.github.com/users/${name}/events 2>/dev/null | jq '.[] | if .type == "PullRequestEvent" then
    {
        repo: .repo.name,
        type: .type,
        action: .payload.action,
        PR: {
            comment: .payload.pull_request.body,
            head: .payload.pull_request.head.label,
            link: .payload.pull_request.url
        }
    }
    elif .type == "CreateEvent" then
        {
            repo: .repo.name,
            type: .type,
            ref: .payload.ref,
        }
    elif .type == "PushEvent" then
        {
            repo: .repo.name,
            type: .type,
            size: .payload.size,
            ref: .payload.ref,
        }
    else
        {
            repo: .repo.name,
            type: .type,
        }
    end'
}
