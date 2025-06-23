# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


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
