# Flipper

A collection of GitHub Actions designed to automate and streamline the CI/CD pipeline for Flutter apps, enabling efficient builds, thorough testing, and seamless deployments.

# Installation

To get started, the necessary files from this repository must be copied into the target project. This can be done by either cloning the repository and copying files manually or running the automated setup script.

```bash
bash <(curl -sL https://raw.githubusercontent.com/witetech/flipper/main/setup.sh)
```

# Usage 

## Analyze

The analyze workflow performs a static code analysis on the codebase. It checks for potential issues and violations of the Dart and Flutter style guide. It uses the `analysis_options.yaml` file to configure the analysis.

The status of the last run can be seen on the badge:

```
![Analyze](https://github.com/OWNER/REPOSITORY/actions/workflows/analyze.yaml/badge.svg)
```