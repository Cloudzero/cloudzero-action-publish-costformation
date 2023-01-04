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

      ###########################
      # The next two job steps are configured to be mutually exclusive.
      # 
      # "Validate Definitions" runs on all branches BUT main. This job step uses the publish API, but sets the field 'validate_only' to true
      # so that the definitions are not actually published, but only validated. NOTE: This step is not needed on main because the validation
      # will happen as part of the publish.
      #
      # "Publish Definitions" runs only on the main branch. This job step calls the same API, but sets the field 'validate_only' to false.
      # This causes the definitions to get published if they pass the validation.
      ###########################

      - name: Validate Definitions
        if: github.ref != 'main'  # Do not run this on the main branch because the 'Publish Definitions' step will perform the validation.
        uses: Cloudzero/cloudzero-action-publish-costformation@v1.0.0
        with:
          file: src/definitions.cz.yaml
          api-key: ${{ secrets.CZ_API_KEY }}
          validate-only: true  # This setting causes the definitions to be validated and then the results of the validation returned without actually publishing the definitions.

      - name: Publish Definitions
        if: github.ref == 'main'  # Only run this on the main branch so definitions that have not been reviewed are not actually published.
        uses: Cloudzero/cloudzero-action-publish-costformation@v1.0.0
        with:
          file: src/definitions.cz.yaml
          api-key: ${{ secrets.CZ_API_KEY }}
          validate-only: false  # This setting causes the definitions to be validated and then published if they pass validation.

```

In the above example `secrets.CZ_API_KEY` is the organization's API key for the CloudZero platform and is stored in the environment `production`.
The definitions are only published when pushed to the branch `main` and all other branches perform validation of the definitions.
