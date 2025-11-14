# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [3.1.2](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v3.1.1...v3.1.2) (2025-11-14)

### Bug Fixes

* **AG-0:** add run.jobs.update permission for stack update operations ([#54](https://github.com/upwindsecurity/terraform-google-onboarding/issues/54)) ([acb0278](https://github.com/upwindsecurity/terraform-google-onboarding/commit/acb0278e91939a40cf27fef140d586faab304569))

## [3.1.1](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v3.1.0...v3.1.1) (2025-11-14)

### Bug Fixes

* add missing permissions for certain cases ([#51](https://github.com/upwindsecurity/terraform-google-onboarding/issues/51)) ([41c4793](https://github.com/upwindsecurity/terraform-google-onboarding/commit/41c47931675eb5e1ae56554a2d4c05fee0dca3c0))

## [3.0.0](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.7.6...v3.0.0) (2025-09-12)

### ⚠ BREAKING CHANGES

* creates a shared module `_shared`, and moves API enablement there.
  Further resources will be moved across in stages.

* chore(AG-3628): remove APIs to rely on external script, move project based roles to shared

* chore(AG-3628): move remaining resources to shared module - secrets and WIF

* chore(AG-3628): add labels by default to applicable resources

* chore(AG-3628): remove unused API variables, other var cleanup

* feat(AG-3628): add folder deployment option

* chore(AG-3628): update READMEs

* chore(AG-3628): add dummy secret with user defined labels for later use

* chore(AG-3628): add missing moved block for compute agent minimal permissions

* chore(AG-3628): add moved blocks for secrets

* feat!(AG-3628): support gcp onboarding at project multiproject and folder level ([#48](https://github.com/upwindsecurity/terraform-google-onboarding/issues/48)) ([0f966f5](https://github.com/upwindsecurity/terraform-google-onboarding/commit/0f966f5276715f5ae21311ab0125531d299cf36f))

## [2.7.4](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.7.3...v2.7.4) (2025-08-19)

### Bug Fixes

* **AG-3477:** missing cloud asset role for customer asset collector ([#43](https://github.com/upwindsecurity/terraform-google-onboarding/issues/43)) ([e157832](https://github.com/upwindsecurity/terraform-google-onboarding/commit/e1578328d6540c3a4bf6e9bf9e7afdfd23ea3086))

## [2.7.3](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.7.2...v2.7.3) (2025-08-12)

### Bug Fixes

* **AG-3477:** add asset viewer role ([#41](https://github.com/upwindsecurity/terraform-google-onboarding/issues/41)) ([a5d5d31](https://github.com/upwindsecurity/terraform-google-onboarding/commit/a5d5d31e0a9c6a8aff9559d85bd5ebea1596e73e))

## [2.7.2](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.7.1...v2.7.2) (2025-08-12)

### Bug Fixes

* **AG-3476:** add folderViewer permissions to management account ([#39](https://github.com/upwindsecurity/terraform-google-onboarding/issues/39)) ([b50810f](https://github.com/upwindsecurity/terraform-google-onboarding/commit/b50810f5db1462bf1247a62505b9cac20a6bb414))

## [2.7.1](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.7.0...v2.7.1) (2025-07-23)

### Bug Fixes

* **AG-3232:** add output for workload identity pool provider full path ([#36](https://github.com/upwindsecurity/terraform-google-onboarding/issues/36)) ([98a7da5](https://github.com/upwindsecurity/terraform-google-onboarding/commit/98a7da512a6613c756c0269c85a1ee27beb9ba78))

## [2.7.0](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.6.0...v2.7.0) (2025-07-23)

### Features

* **AG-3214:** remove unnecessary IAM write role as all IAM creation is now handled within onboarding ([#35](https://github.com/upwindsecurity/terraform-google-onboarding/issues/35)) ([ebb2202](https://github.com/upwindsecurity/terraform-google-onboarding/commit/ebb2202155a6005897675d31d533bd4077c6fb5a))

## [2.6.0](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.5.3...v2.6.0) (2025-07-18)

### Features

* **AG-3170:** update for ME region ([#33](https://github.com/upwindsecurity/terraform-google-onboarding/issues/33)) ([2cb8170](https://github.com/upwindsecurity/terraform-google-onboarding/commit/2cb81702ccddf84a784c4373f5b48dc45aa23c35))

## [2.5.3](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.5.2...v2.5.3) (2025-07-01)

### Bug Fixes

* **AG-3041:** add missing instanceGroupManagers.update permission for updating scanners ([#26](https://github.com/upwindsecurity/terraform-google-onboarding/issues/26)) ([49a345b](https://github.com/upwindsecurity/terraform-google-onboarding/commit/49a345bc631aebca17850ec116b17c48872ecc48))

## [2.5.1](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.5.0...v2.5.1) (2025-06-26)

### Bug Fixes

* **AG-2990:** fix role conditions to use extract with template instead of regex ([#21](https://github.com/upwindsecurity/terraform-google-onboarding/issues/21)) ([c588dc9](https://github.com/upwindsecurity/terraform-google-onboarding/commit/c588dc9b4e2b806d53533a588e7534c8ee0d1288))

## [2.5.0](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.4.3...v2.5.0) (2025-06-26)

### Features

* **AG-2991:** add storage bucket read permissions to management account ([#19](https://github.com/upwindsecurity/terraform-google-onboarding/issues/19)) ([f60be49](https://github.com/upwindsecurity/terraform-google-onboarding/commit/f60be49ef4f6213af50e30675f1e67673e831205))

## [2.4.3](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.4.2...v2.4.3) (2025-06-23)

### Bug Fixes

* **AG-2954:** permissions fixes for scaling and scanning, reorganisation of roles ([#16](https://github.com/upwindsecurity/terraform-google-onboarding/issues/16)) ([0e8bdac](https://github.com/upwindsecurity/terraform-google-onboarding/commit/0e8bdac89be5e9792e8d156a72ea234859936fb5))

## [2.4.2](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.4.1...v2.4.2) (2025-06-18)

### Bug Fixes

* **AG-2937:** fix role name for snapshot reader/writer ([#14](https://github.com/upwindsecurity/terraform-google-onboarding/issues/14)) ([650d41e](https://github.com/upwindsecurity/terraform-google-onboarding/commit/650d41e0017ea8edb40490a231cdf16831185c15))

## [2.4.1](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.4.0...v2.4.1) (2025-06-18)

### Bug Fixes

* **AG-2928:** move disks.createSnapshot permission, fix empty workload ([#12](https://github.com/upwindsecurity/terraform-google-onboarding/issues/12)) ([c03e6ef](https://github.com/upwindsecurity/terraform-google-onboarding/commit/c03e6efa15edc998fb7a489cc0c90232d78084e1))

## [2.4.0](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.3.0...v2.4.0) (2025-06-17)

### Features

* **AG-2923:** reduce storageAdmin role to only required permissions ([#9](https://github.com/upwindsecurity/terraform-google-onboarding/issues/9)) ([e16bc75](https://github.com/upwindsecurity/terraform-google-onboarding/commit/e16bc7538af8881ddee8b4d124c11fba06a9b02d))


## [2.3.0](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.2.0...v2.3.0) (2025-06-17)

### Features

* **AG2922:** remove token creator bindings, allow cloudscanner to impersonate scaler ([#8](https://github.com/upwindsecurity/terraform-google-onboarding/issues/8)) ([9ac7555](https://github.com/upwindsecurity/terraform-google-onboarding/commit/9ac7555b90d3f19c7c9f5e85ce6422396db9d1ef))

## [2.2.0](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.1.0...v2.2.0) (2025-06-17)

### Features

* **AG-2921:** add variable to control WIF project ([#6](https://github.com/upwindsecurity/terraform-google-onboarding/issues/6)) ([d1e65c0](https://github.com/upwindsecurity/terraform-google-onboarding/commit/d1e65c0d3430acde20c42f89a7468a59a70a989e))
## [2.1.0](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.0.0...v2.1.0) (2025-06-16)

### Features

* update release workflow and CI/CD pipeline ([#3](https://github.com/upwindsecurity/terraform-google-onboarding/issues/3)) ([870d989](https://github.com/upwindsecurity/terraform-google-onboarding/commit/870d98904360cb9b6111b55a8d037081a288f4c8))

### Bug Fixes

* clean up whitespace and formatting in workflow and documentation files ([#4](https://github.com/upwindsecurity/terraform-google-onboarding/issues/4)) ([fcaedcd](https://github.com/upwindsecurity/terraform-google-onboarding/commit/fcaedcddda35d8a8f0a5bbf7f66ebb0cbfef02e4))

## [2.0.0](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v1.0.0...v2.0.0) (2025-06-16)

### ⚠ BREAKING CHANGES

* **AG-2890:** this upgrades the Upwind GCP deployments
    to use Workload Identity Federation instead of directly
    using Service Accounts by creating a private key.

    An identity pool is created and trust is configured with the
    Upwind AWS account. It will be necessary for a customer to
    provide a credential configuration for WIF after creation
    using the gcloud command specified in the documentation, and
    uploading this to Upwind.

### Features

* **AG-2890:** GCP Workload Identity Federation ([#1](https://github.com/upwindsecurity/terraform-google-onboarding/issues/1)) ([629dee6](https://github.com/upwindsecurity/terraform-google-onboarding/commit/629dee6529ebd9945e6f034202a0a938b1a4da4f))

## [2.0.1](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v2.0.0...v2.0.1) (2025-06-16)

### Bug Fixes

* **AG-2911:** update changelog and manage tags ([23ba690](https://github.com/upwindsecurity/terraform-google-onboarding/commit/23ba690e942aeaacccd73395c66a4e65dd86e16f))

## [2.0.0](https://github.com/upwindsecurity/terraform-google-onboarding/compare/v1.0.0...v2.0.0) (2025-06-12)

### ⚠ BREAKING CHANGES

* **AG-2670:** Implements Workload Identity Federation for GCP organization onboarding, replacing prior Service Account key creation method.

### Features

* **AG-2670:** Implements Workload Identity Federation for GCP organization onboarding, replacing prior Service Account key creation method.

## 1.0.0 (2025-06-09)

Initial commit of onboarding modules.
