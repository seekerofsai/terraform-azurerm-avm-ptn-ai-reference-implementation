---
title: ADR Template

# These are optional elements. Feel free to remove any of them.
# status: {proposed | rejected | accepted | deprecated | … | superseded by [ADR-0005](0005-example.md)}
# date: {YYYY-MM-DD when the decision was last updated}
# deciders: {list everyone involved in the decision}
# consulted: {list everyone whose opinions are sought (typically subject-matter experts); and with whom there is a two-way communication}
# informed: {list everyone who is kept up-to-date on progress; and with whom there is a one-way communication}
---
<!-- we need to disable MD025, because we use the different heading "ADR Template" in the homepage (see above) than it is foreseen in the template -->
<!-- markdownlint-disable-file MD025 -->

Status: accepted

# Options for pypi packages to build solutions from AML


Date: 16 August 2024

## Context and Problem Statement

Customers need a secure supply package solution for developers. The AIRI implementation aims to be secure by default but offer flexibility to conform with a customer's chosen approach to secure supply for developer packages.

<!-- This is an optional element. Feel free to remove. -->
## Decision Drivers

* The solution must offer a secure but flexible approach to package supply for developers.

## Considered Options

* Allow outbound access from AML/AI Studio
* Containerize all solutions
* Pre-download the packages for solutions
* Use an artefact management solution

## Decision Outcome

Allow outbound access from AML/AI Studio but include in the documentation that this will need to be disabled for all environments.

## Pros and Cons of the Options

### Allow outbound access from AML/AI Studio

Allow outbound access from AML/AI Studio but include in the documentation that this will need to be disabled off for all environments.

#### Positive Consequences

Simplifies the internal development process and provides flexibility to customers to introduce their solution to secure package management. It will need to be strongly documented that this manual step needs to take place for a secure deployment of the AIRI project.

#### Negative Consequences

The risk exists that customers overlook this step and introduce packages to their environments that have not been scanned and validated.

### Containerize all solutions

Containerize all solutions built on AIRI. Container image scanning will be required and customers may already have a solution in place. Conforming to the first principles of the AIRI project, we do not want to add anything that is not mandatory and reduces flexibility for brownfield deployments.

<!-- This is an optional element. Feel free to remove. -->
#### Positive Consequences

* All solutions can be pre-built and consistently scanned and validated in a container image.

<!-- This is an optional element. Feel free to remove. -->
#### Negative Consequences

* Introduces additional components to the solution that would likely be replaced by a customer with their own solution and would introduce complexity and cost to the solution now that would reduce development velocity. Conforming to the first principles of the AIRI project, we do not want to add anything that is not mandatory and reduces flexibility for brownfield deployments.

<!-- This is an optional element. Feel free to remove. -->

### Pre-download the packages for solutions

Pre-download the packages for solutions and then mount them in the solution storage for build. Conforming to the first principles of the AIRI project, we do not want to add anything that is not mandatory and reduces flexibility for brownfield deployments.

<!-- This is an optional element. Feel free to remove. -->
#### Positive Consequences

* All packages can be pre-downloaded and consistently scanned and validated.

<!-- This is an optional element. Feel free to remove. -->
#### Negative Consequences

* This approach does not conform to the first principal of the AIRI project, in that we do not want to add anything to the customer solution that is not mandatory and reduces flexibility for brownfield deployments.

### Use an artefact management solution

Use an artefact management solution such as [Azure Artefacts](https://learn.microsoft.com/en-us/azure/devops/artifacts/start-using-azure-artifacts?view=azure-devops&tabs=nuget%2Cnugetserver). 

#### Positive Consequences

A central artefact management system would allow for central build and deployment of surrounding AIRI solutions. This would benefit the CI/CD pipeline for internal development.

#### Negative Consequences

Conforming to the first principles of the AIRI project, we do not want to add anything to the customer facing solution that is not mandatory and reduces flexibility for brownfield deployments.

## Validation

The proposal was validated by the AIRI core group.

