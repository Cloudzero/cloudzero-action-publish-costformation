# Publish CloudZero CostFormation

This is a GitHub action to publish CloudZero CostFormation definitions to the CloudZero platform.
It will only perform a full publish when running on a specified branch

# Usage

```yaml
      - name: <name>
        uses: Cloudzero/cloudzero-action-publish-costformation@v1.0.0
        with:
          file: <path to definitions file>
          api-key: <CloudZero platform API key (should be taken from environment secrets)>
          validate-only: <true|false>
```

# Example

```yaml

# Example workflow using publish actions

name: Publish CloudZero CostFormation

on:
  push:

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

jobs:
  publish:
    runs-on: ubuntu-latest
    environment: production
    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
      - uses: actions/checkout@v3

      - name: Validate Definitions
        if: github.ref != 'main'
        uses: Cloudzero/cloudzero-action-publish-costformation@v1.0.0
        with:
          file: src/definitions.cz.yaml
          api-key: ${{ secrets.CZ_API_KEY }}
          validate-only: true

      - name: Publish Definitions
        if: github.ref == 'main'
        uses: Cloudzero/cloudzero-action-publish-costformation@v1.0.0
        with:
          file: src/definitions.cz.yaml
          api-key: ${{ secrets.CZ_API_KEY }}
          validate-only: false

```

In the above example `secrets.CZ_API_KEY` is the organization's API key for the CloudZero platform and is stored in the environment `production`.
The definitions are only published when pushed to the branch `main` and all other branches perform validation of the definitions.
