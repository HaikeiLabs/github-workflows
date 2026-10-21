# github-workflows
Reusable GitHub Actions workflows shared across HaikeiLabs repos

## Release announcements

Call the reusable workflow when a GitHub release is published. Pass the organization webhook secret through the `webhook` secret; the workflow masks it and does not expose it in the payload.

```yaml
on:
  release:
    types: [published]

jobs:
  announce:
    uses: HaikeiLabs/github-workflows/.github/workflows/release-discord.yml@main
    with:
      tag: ${{ github.event.release.tag_name }}
      notes: ${{ github.event.release.body }}
    secrets:
      webhook: ${{ secrets.DISCORD_RELEASES_WEBHOOK }}
```

Repositories that publish tags without creating GitHub releases can call the workflow from a tag-push workflow using `on: push` with a `tags` filter and pass `github.ref_name` as `tag`.
