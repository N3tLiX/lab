
gh api repos/N3tLiX/lab/actions/runs \
| jq -r '.workflow_runs[] | select(.head_branch != "main") | "\(.id)"' \
| xargs -n1 -I % gh api repos/N3tLiX/lab/actions/runs/% -X DELETE

# Remove all Workspaces
gh api repos/N3tLiX/lab/actions/runs \
| jq -r '.workflow_runs[] | select(.head_branch != "") | "\(.id)"' \
| xargs -n1 -I % gh api repos/N3tLiX/lab/actions/runs/% -X DELETE

