# GCP Tamr IAM module

## v3.0.1 - May 6th 2024
* Update Google terraform provider version

## v2.0.1 - April 7th 2022
* Fix issue with outputs

## v2.0.0 - April 5th 2023
* Following input variables now required
  * tamr_service_account
* Following input variables are removed from the main module
  * tamr_service_account_name
* Allows flexibility for the user of this module to either create a new service account or use an existing one

## v1.1.0 - July 27th 2022
* Add cloudsql admin permissions

## v1.0.0 - June 1st 2022
* Set minimum terraform to 1.0.0 and minimum google provider to 4.6.0

## v0.1.3 - May 24th 2022
* Fix typo for resource field (from "members" to "member")

## v0.1.2 - January 24th 2022
* Add missing iam.serviceAccountUser role needed to run Tamr jobs

## v0.1.1 - October 16th 2020
* Add missing project param

## v0.1.0 - February 25th 2020
* Initing project
