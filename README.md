# cloudzero-action-publish-costformation

This is a GitHub action to publish CostFormation definitions to the CloudZero platform.
It will only perform a full publish when running on a specified branch

# Usage

```yaml

# Example workflow using publish actions

name: Publish CostFormation

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
        uses: Cloudzero/cloudzero-action-publish-costformation@v1
        with:
          file: src/definitions.cz.yaml
          api-key: ${{ secrets.CZ_API_KEY }}
          validate-only: true

      - name: Publish Definitions
        if: github.ref == 'main'
        uses: Cloudzero/cloudzero-action-publish-costformation@v1
        with:
          file: src/definitions.cz.yaml
          api-key: ${{ secrets.CZ_API_KEY }}
          validate-only: false

```