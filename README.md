# Terraform Modules for Google Cloud Onboarding

[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Google Cloud](https://img.shields.io/badge/Google%20Cloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)](https://cloud.google.com/)
[![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/features/actions)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg?style=for-the-badge)](https://opensource.org/licenses/Apache-2.0)

A comprehensive collection of Terraform modules for onboarding Google Cloud projects and organizations to the Upwind
platform, enabling seamless integration for monitoring and security analysis.

## Modules

This repository contains the following Terraform modules for Google Cloud onboarding:

- [modules/project/](./modules/project/) - Project-level onboarding module for connecting individual Google Cloud
  projects to the Upwind platform
- [modules/organization/](./modules/organization/) - Organization-level onboarding module for comprehensive monitoring
  and security analysis across entire Google Cloud organizations

## Examples

Complete usage examples are available in the [examples](./examples/) directory:

- [examples/project/](./examples/project/) - Basic project onboarding example demonstrating single Google Cloud project integration
- [examples/organization/](./examples/organization/) - Advanced organization-level onboarding with multiple project
  scenarios and conditional deployments

## Contributing

We welcome contributions! Please see our [CONTRIBUTING.md](./CONTRIBUTING.md) guide for details on:

- Development setup and workflows
- Testing procedures
- Code standards and best practices
- How to add new submodules

For bug reports and feature requests, please use
[GitHub Issues](https://github.com/upwindsecurity/terraform-google-onboarding/issues).

## Versioning

We use [Semantic Versioning](http://semver.org/) for releases. For the versions
available, see the [tags on this repository](https://github.com/upwindsecurity/terraform-google-onboarding/tags).

## License

This project is licensed under the Apache License 2.0. See the [LICENSE](LICENSE) file for details.

## Workflows

Please see the [Actions Page](https://github.com/upwindsecurity/terraform-google-onboarding/actions) for automations

## Support

- [Documentation](https://docs.upwind.io)
- [Issues](https://github.com/upwindsecurity/terraform-google-onboarding/issues)
- [Contributing Guide](./CONTRIBUTING.md)
