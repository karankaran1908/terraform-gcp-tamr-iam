# GCP Tamr IAM Permissions
This module is used to create the IAM bindings that tamr needs to create resources that aren't provisioned by terraform. For example permissions for tamr to use ephemeral dataproc clusters.
This repo follows the [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure).

# Resources Created
This modules creates:
* IAM bindings for tamr
* (optionally) a service account for tamr to use

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| google | >= 4.6.0 |

## Providers

| Name | Version |
|------|---------|
| google | >= 4.6.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | project to create bindings in | `string` | n/a | yes |
| additional\_users | additional IAM identities to give IAM access to | `list(string)` | `[]` | no |
| enabled\_bigquery\_perms | Create IAM role bindings to allow the service account to use bigquery | `bool` | `true` | no |
| enabled\_monitoring\_perms | Create IAM role bindings to allow the service account to write telemetry to stackdriver | `bool` | `true` | no |
| tamr\_service\_account | If provided this service account will be given permissions tamr needs to run. If not set a service account will be created. | `string` | `""` | no |
| tamr\_service\_account\_name | Name of service account to create. NOTE: this is only created if tamr\_service\_account is left empty. | `string` | `"tamr"` | no |

## Outputs

| Name | Description |
|------|-------------|
| service\_account\_email | Email of the service account given permissions to |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

# References
This repo is based on:
* [terraform standard module structure](https://www.terraform.io/docs/modules/index.html#standard-module-structure)
* [templated terraform module](https://github.com/tmknom/template-terraform-module)

# Development
## Generating Docs
Run `make terraform/docs` to generate the section of docs around terraform inputs, outputs and requirements.

## Checkstyles
Run `make lint`, this will run terraform fmt, in addition to a few other checks to detect whitespace issues.
NOTE: this requires having docker working on the machine running the test

## Releasing new versions
* Update version contained in `VERSION`
* Document changes in `CHANGELOG.md`
* Create a tag in github for the commit associated with the version

# License
Apache 2 Licensed. See LICENSE for full details.
